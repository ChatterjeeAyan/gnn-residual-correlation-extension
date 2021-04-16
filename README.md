## Extension of the Work on Outcome Correlation in Graph Neural Network Regression

### This repository replicates the results found in the following paper and extends to more datasets:  
[Outcome Correlation in Graph Neural Network Regression](https://arxiv.org/abs/2002.08274)  
[Junteng Jia](https://000justin000.github.io/), and [Austin R. Benson](https://www.cs.cornell.edu/~arb/)  
KDD, 2020.

The paper identifies the fact that GNN regression residuals are oftentimes correlated among neighboring vertices, and we propose simple and efficient algorithms to explore the correlation structure:
- C-GNN models the correlation as a multivariate Gaussian and learns the correlation structure in O(m) per optimization step, where m is the number of edges.
- LP-GNN assumes positive correlation among neighboring vertices, and runs label propagation to interpolate GNN residuals on the testing vertices.

The code is tested under in Julia 1.0.5, you can install all dependent packages by running.
```
julia env.jl
```
As an extension, the effect of homophily has been studied on the models. Different Ising models with varying homophily have been used for this purpose. 

The reproduced outputs are available in [/new logs](/new logs).

If you have any questions, please email to [chatterjee.ay@northeastern.edu](mailto:chatterjee.ay@northeastern.edu).
