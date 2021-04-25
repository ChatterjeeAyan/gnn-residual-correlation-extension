include("run_dataset.jl");

regressor, correlation, inductive = ARGS[1], ARGS[2], parse(Bool, ARGS[3]);

if inductive
    run_dataset("ising_35_0.10_0.35",  ["ising_35_0.10_0.35"],  sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.35", ["ising_35_0.10_-0.35"], sign_accuracy, regressor, correlation, inductive);
    run_dataset("county_income_2012", ["county_income_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_education_2012", ["county_education_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_unemployment_2012", ["county_unemployment_2016"], R2, regressor, correlation, inductive);
    run_dataset("county_election_2012", ["county_election_2016"], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_airT", ["climate_2008_airT"], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_landT", ["climate_2008_airT"], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_precipitation", ["climate_2008_precipitation"], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_sunlight", ["climate_2008_sunlight"], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_pm2.5", ["climate_2008_pm2.5"], R2, regressor, correlation, inductive);
else
    run_dataset("ising_35_0.10_0.35",  [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("ising_35_0.10_-0.35", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("county_income_2012", [], R2, regressor, correlation, inductive);
    run_dataset("county_education_2012", [], R2, regressor, correlation, inductive);
    run_dataset("county_unemployment_2012", [], R2, regressor, correlation, inductive);
    run_dataset("county_election_2012", [], R2, regressor, correlation, inductive);
    run_dataset("Anaheim", [], R2, regressor, correlation, inductive);
    run_dataset("ChicagoSketch", [], R2, regressor, correlation, inductive);
    run_dataset("sexual_1", [], sign_accuracy, regressor, correlation, inductive);
    run_dataset("twitch_PTBR_true_8", [], R2, regressor, correlation, inductive);
    #run_dataset("CoxData", [], R2, regressor, correlation, inductive);
    #run_dataset("KKIData", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2008_airT", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2008_landT", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2008_precipitation", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2008_sunlight", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2008_pm2.5", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_airT", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_landT", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_precipitation", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_sunlight", [], R2, regressor, correlation, inductive);
    run_dataset("climate_2007_pm2.5", [], R2, regressor, correlation, inductive); 
end
