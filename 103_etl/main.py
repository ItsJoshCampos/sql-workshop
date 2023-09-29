import pandas as pd
from sqlalchemy import create_engine, text
import hashlib
import os
from dotenv import load_dotenv
from datetime import datetime
import sys

# Load environment variables from .env file
load_dotenv()

# Database configuration
DATABASE = {
    'dbname': os.getenv('DB_NAME'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'host': os.getenv('DB_HOST'),
    'port': os.getenv('DB_PORT')
}

# extensions
def eprint(*args, **kwargs):
    now_string = str(datetime.now())
    print(now_string, *args, file=sys.stderr, **kwargs)

def csv_to_df(filename):
    eprint(f'INFO: Processed CSV ({filename}) to dataframe')
    return pd.read_csv(filename)

def mask_data(data):
    # Mask patient names for privacy
    data['masked_name'] = data['full_name'].apply(lambda x: hashlib.sha256(x.encode()).hexdigest())
    data.drop('full_name', axis=1, inplace=True)

    return data
# end extensions

# sql utilities
def get_sql_text(path):
    with open(path, 'r') as dot_sql_file:
        sql_query = dot_sql_file.read()
        eprint(f'INFO: Read file {path}')
    return sql_query

def execute_sql(engine, sql_text):
    with engine.begin() as conn:
        conn.execute(text(sql_text))
        eprint(f'INFO: Executed SQL command: {sql_text}')

def upload_to_sql(db_engine, table, data):
    data.to_sql(table, db_engine, if_exists='append', index=False)
    eprint(f'INFO: Uploaded data to {table}')
# end utilities


def main():
    # Create a connection string
    DATABASE_URL = f"postgresql+psycopg2://{DATABASE['user']}:{DATABASE['password']}@{DATABASE['host']}:{DATABASE['port']}/{DATABASE['dbname']}"
    engine = create_engine(DATABASE_URL)

    table_name = os.getenv('TABLE_NAME')

    # clean up staging
    table_truncate_text = get_sql_text("sql/truncate_staging.sql")
    execute_sql(engine, table_truncate_text)

    # Get CSV filena from environment variables
    patient_file_name = os.getenv('CSV_FILENAME')

    # read csv file to dataframe
    patient_feed = csv_to_df(patient_file_name)

    # mask the patient's name
    patient_data = mask_data(patient_feed)

    # load staging to sql
    upload_to_sql(engine, table_name, patient_feed)


if __name__ == "__main__":
    main()
