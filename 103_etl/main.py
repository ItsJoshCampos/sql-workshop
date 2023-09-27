import pandas as pd
from sqlalchemy import create_engine
import hashlib
import os
from dotenv import load_dotenv

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


def csv_to_df(filename):
    return pd.read_csv(filename)

def mask_data(data):
    # Mask patient names for privacy
    data['MaskedName'] = data['full_name'].apply(lambda x: hashlib.sha256(x.encode()).hexdigest())
    data.drop('full_name', axis=1, inplace=True)
    
    return data

def upload_to_sql(data, db_engine):
    data.to_sql('patient_history', db_engine, if_exists='append', index=False)

def main():
    # Create a connection string
    DATABASE_URL = f"postgresql+psycopg2://{DATABASE['user']}:{DATABASE['password']}@{DATABASE['host']}:{DATABASE['port']}/{DATABASE['dbname']}"

    engine = create_engine(DATABASE_URL)

    # Get CSV filena from environment variables
    patient_file_name = os.getenv('CSV_FILENAME')
    
    patient_feed = csv_to_df(patient_file_name)
    
    # patient_data = mask_data(patient_feed)

    # load staging
    upload_to_sql(patient_feed, engine)


if __name__ == "__main__":
    main()
