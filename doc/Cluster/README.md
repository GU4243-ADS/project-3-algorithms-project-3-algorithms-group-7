# Cluster Model

1. Run `data_clean.Rmd`. This generates `movie_train.csv` in the `Downloads` folder.

2. Run `train_test_data_preprocessing.Rmd`. This generates `movie_test.csv` and `movie_test_train_new.csv` in the `Downloads` folder.

3. `em.R` contains the code to run the expectation maximization algorithm. There are subfunctions for `Expectation` and `Maximization`, and a main function for E.M. Code at the bottom of the script runs the algorithm on randomly initiated start values for `mu` and `gamma`. This takes a long time.

4. Run `cluster_prediction.Rmd`. This generates new predictions based off of previously-generated `mu` and `gamma` values. The prediction step can take some time. (The previously generated spreadsheets are used in the prediction step.)