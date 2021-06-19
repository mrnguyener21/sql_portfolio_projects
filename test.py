import pandas as pd;

one = pd.read_csv('covid_19_database/Covid19__US_Cases.csv');
two = pd.read_csv('covid_19_database/Covid19__US_Deaths.csv');

print(one.info())
print(two.info())