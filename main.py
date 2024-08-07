import sqlite3
import pandas as pd
import os

#Create path to csv
csv_file_path = os.path.join('temp', 'JOB_SUBMISSION.csv')
sqlite3_db_file_path = os.path.join('temp', 'applications.db')
sqlite3_db_ddl_file_path = os.path.join('sql', 'ddl', 'init.sql')
#Load our data frame from the csv file
df = pd.read_csv(csv_file_path)


#Create a function to handle date conversion
def parse_dates(date_str):
    for fmt in ('%m/%d/%Y %H:%M:%S', '%m/%d/%Y'):
        try:
            return pd.to_datetime(date_str, format=fmt)
        except ValueError:
            pass
    raise ValueError(f"Date format not recognized for: {date_str}")


#Convert timestamp to a date format
df['Timestamp'] = df['Timestamp'].apply(parse_dates)

# Replace spaces with underscores
df.columns = df.columns.str.replace(' ', '_')


# Create the connection to our sqlite3 database
conn = sqlite3.connect(sqlite3_db_file_path)

# Create our cursor object
cursor = conn.cursor() 


# Get our SQL init stuffs and run it
with open(sqlite3_db_ddl_file_path, 'r') as file:
    sqlite3_db_ddl_script = file.read()
    cursor.executescript(sqlite3_db_ddl_script)

#Insert from csv into job_submissions 
df.to_sql('job_submission', conn, if_exists='replace', index=False)






