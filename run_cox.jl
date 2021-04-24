using Random;
using Statistics;
using StatsBase: sample, randperm, mean;
using LinearAlgebra;
using SparseArrays;
using IterativeSolvers;
using LightGraphs;
using Flux;
using GraphSAGE;
using BSON: @save, @load;
using Printf;

include("read_network.jl");
include("utils.jl");

regressor = "mlp"
correlation = "learned"

G, A, labels, feats = read_network("CoxData");
d = sum(sum(A), dims=1)[:];
S = [spdiagm(0=>d.^-0.5)*A_*spdiagm(0=>d.^-0.5) for A_ in A];

accuracyFun = R2;

n = nv(G);
ptr = 0.6;
dim_h = 32;
dim_out = 8;
L, VU = rand_split(n, ptr);
V, U = VU[1:div(length(VU),2)], VU[div(length(VU),2)+1:end];

ab = param(vcat(zeros(length(A)), 3.0));
getα() = tanh.(ab[1:end-1]);
getβ() = exp(ab[end]);

if regressor == "zero"
    getRegression = L -> zeros(length(L));
    θ = params();
    optθ = ADAM(0.0);
elseif regressor == "linear"
    lls = Dense(length(feats[1]), 1);
    getRegression = L -> lls(hcat([feats[u] for u in L]...))[:];
    θ = params(lls);
    optθ = ADAM(0.1);
elseif regressor == "mlp"
    mlp = Chain(Dense(length(feats[1]), dim_h, relu), Dense(dim_h, dim_h, relu), Dense(dim_h, dim_out, relu), Dense(dim_out, 1));
    getRegression = L -> mlp(hcat([feats[u] for u in L]...))[:];
    θ = params(mlp);
    optθ = ADAM(0.001);
elseif regressor == "gnn"
    enc = graph_encoder(length(feats[1]), dim_out, dim_h, repeat(["SAGE_Mean"], 2); σ=relu);
    reg = Dense(dim_out, 1);
    getRegression = L -> reg(hcat(enc(G, L, u->feats[u])...))[:];
    θ = params(enc, reg);
    optθ = ADAM(0.001);
else
    error("unexpected regressor type");
end

t, k, num_steps = 128, 32, 1500;
optφ = Descent(0.1);
φ_skip = 10;

getrL(L) = labels[L] - getRegression(L);
function getΩ(α, β, rL, L, logdet)
    Ω = quadformSC(α, β, rL; S=S, L=L);
    logdet && (Ω -= (logdetΓ(α, β; S=S, P=collect(1:nv(G)), t=t, k=k) - logdetΓ(α, β; S=S, P=setdiff(1:nv(G),L), t=t, k=k)));
    return Ω;
end
function loss(L; getα=getα, getβ=getβ, logdet=false)
    rL = getrL(L);
    Ω = getΩ(getα(), getβ(), rL, L, logdet);
    return Ω / length(L);
end

dat(x) = data.(data(x));

function call_back()
    @printf("%6.3f,    %6.3f,    [%s],    %6.3f\n",
            accuracyFun(labels[L], dat(pred(L,V; G=G,labels=labels,predict=getRegression,α=((correlation == "homo") ? ones(length(A))*0.99 : getα()),β=getβ(),S=S))),
            accuracyFun(labels[V], dat(pred(V,L; G=G,labels=labels,predict=getRegression,α=((correlation == "homo") ? ones(length(A))*0.99 : getα()),β=getβ(),S=S))),
            array2str(getα()),
            getβ());
end

mini_batch_size = Int(round(length(L) * 0.05));
mini_batches = [sample(L, mini_batch_size, replace=false) for _ in 1:num_steps];
train!(loss, getrL, getΩ,
       (correlation == "learned") ? true : false,
       θ,
       params(ab),
       mini_batches, L,
       optθ, optφ;
       cb=call_back, φ_start=0, φ_skip=φ_skip, cb_skip=100);
