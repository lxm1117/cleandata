The R code reads in the unzipped fitbit data. 
It combines test data and training data into a dataframe named data.
Then relabel the column names to make them more descriptive.
Columns in data that are labelled with "mean" and "std" are extracted into a dataframe data_mean_std.
A seperate dataframe named as "avg" is obtained as averaging the data_mean_std by each subjects and activities.
"avg" is saved into a txt file with the name "avg_data.txt".
