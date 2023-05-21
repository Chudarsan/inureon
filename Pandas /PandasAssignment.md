# PandasAssignment

    import pandas as pd

Q1. How do you load a CSV file into a Pandas DataFrame? 

    Using read_csv('filePath')
    Ex:
    df = pd.read_csv('filepath')

Q2. How do you check the data typeof a column in a Pandas DataFrame?
    
    To check dataType for all columns -> df.dtypes
    For specific column -> df['ColumnName'].dtype

Q3. How do you select rows from a Pandas DataFrame based on a condition?

    df.loc - fetches rows based on user altered index
    df.iloc - fetches row based on a system generated index
    If condition is column name='iNeuron'
    df.loc[df['name'] == 'iNeuron']

Q4. How do you rename columns in a Pandas DataFrame?

    Using rename method, Ex below    
    df.rename(columns={"PassengerId": "PassengerIndex"}, inplace=True)

Q5. How do you drop columns in a Pandas DataFrame?
    
    Using drop method, and argument with axis = 1 for column level
    df.drop(['columnName'], axis = 1, inplace=True)

Q6. How do you find the unique values in a column of a Pandas DataFrame?

    Using unique method applied on column, ex as below
    df['Pclass'].unique()

Q7. How do you find the number of missing values in each column of a Pandas DataFrame?
    
    Using isnull() and sum() applied over it, ex as below
    df['Cabin'].isnull().sum()

Q8. How do you fill missing values in a Pandas DataFrame with a specific value?
    
    Using fillna method, ex as below
    df['Cabin'].fillna('Harish', inplace=True)

Q9. How do you concatenate two Pandas DataFrames?
    
    Using concat method as below
    dfC = pd.concat([dfA, dfB])

Q10. How do you merge two Pandas DataFrames on a specific column?

    merged_df = pd.merge(dfA, dfB, on="column")

Q11. How do you group data in a Pandas DataFrame by a specific column and apply an aggregation function?
    
    As below    
    df.groupby(['ColumnName']).sum()

Q12. How do you pivot a Pandas DataFrame?

    df.pivot(index='columnA', columns='columnB', values='columnC')

Q13. How do you change the data typeof a column in a Pandas DataFrame?

    df['Fee'].dtype -> dtype('int64')
    df['Fee'] = df['Fee'].astype('float') -> float64

Q14. How do you sort a Pandas DataFrame by a specific column?

    As below example, in descending order
    df.sort_values('Fare', ascending=False)

Q15. How do you create a copy of a Pandas DataFrame?

    dfCopy = df.copy()

Q16. How do you filter rows of a Pandas DataFrame by multiple conditions?

    Filter with Fare above 5 and Class = 3 --> Result 486 Rows
    df.loc[(df['Fare']>5) & (df['Pclass']==3)].sort_values('Fare', ascending=False)

    Filter with Fare above 50 and Class = 3 --> Result 14 Rows
    df.loc[(df['Fare']>50) & (df['Pclass']==3)].sort_values('Fare', ascending=False)

Q17. How do you calculate the mean of a column in a Pandas DataFrame?
    
    df['Fare'].describe() -> provides all statistical data
    df['Fare'].mean() -> provides mean

Q18. How do you calculate the standard deviation of a column in a Pandas DataFrame?
    
    df['Fare'].std()
    
Q19. How do you calculate the correlation between two columns in a Pandas DataFrame?

    df['Fare'].corr(df['Pclass'])

Q20. How do you select specific columns in a DataFrame using their labels?

    df[['Fare','Pclass']]

Q21. How do you select specific rows in a DataFrame using their indexes?

    df.loc[100]     -> user set index
    df.iloc[100]    -> system generated index
    df[100:140]     -> range of rows

Q22. How do you sort a DataFrame by a specific column?

    df.sort_values('Fare', ascending=False)

Q23. How do you create a new column in a DataFrame based on the values of another column?

    Added New Column 'newCol' based on concatination of Fare and Pclass
    df['newCol'] = df['Fare'].map(str) + '_' + df['Pclass'].map(str)

Q24. How do you remove duplicates from a DataFrame?

    df.drop_duplicates()
    df.drop_duplicates(subset=['column'])
    df.drop_duplicates(subset=['column1', 'column2'], keep='last')

Q25. What is the difference between .loc and .iloc in Pandas?

    If dataframe is altered with index based on user inputs
    df.loc[100] -> will provide row based on user specified index
    df.iloc[100] -> will provide row based on system generated index
