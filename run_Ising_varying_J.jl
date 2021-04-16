include("run_dataset.jl");

regressor, correlation, inductive = ARGS[1], ARGS[2], parse(Bool, ARGS[3]);

if inductive
    run_dataset("ising_35_0.10_0.35",  ["ising_35_0.10_0.35"],  sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.35", ["ising_35_0.10_-0.35"], sign_accuracy, regressor, correlation, inductive);
    run_dataset("county_income_2012", ["county_income_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_education_2012", ["county_education_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_unemployment_2012", ["county_unemployment_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_election_2012", ["county_election_2016"], R2, regressor, correlation, inductive);
else
    run_dataset("ising_35_0.10_0.1",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.2", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.3",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.4", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.5",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.6", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.7",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.8", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_0.9",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.1",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.2", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.3",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.4", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.5",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.6", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.7",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.8", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.9",  [], sign_accuracy, regressor, correlation, inductive);
end
