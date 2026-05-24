import boto3
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO

from quality import verify_data_quality, remove_outliers_iqr


DB_URL = "postgresql://admin:test_pass@postgres:5432/analytics_db"
S3_CONFIG =  {
    "endpoint_url": "http://minio:9000",
    "aws_access_key_id": "admin",
    "aws_secret_access_key": "test_pass",
}

BUCKET_NAME = "lakehouse"
engine = create_engine(DB_URL)
s3_client = boto3.client("s3", **S3_CONFIG)


def ensure_bucket():
    try:
        s3_client.head_bucket(Bucket=BUCKET_NAME)
    except:
        s3_client.create_bucket(Bucket=BUCKET_NAME)


def extract_incremental_telemetry(last_processed_date: str = None):
    ensure_bucket()

    query = "SELECT * FROM telemetry"
    if last_processed_date:
        query += f" WHERE timestamp > '{last_processed_date}'"

    df = pd.read_sql(query, engine)

    if df.empty:
        return

    if not verify_data_quality(df, 'val', max_null_ratio=0.03):
        df['val'] = df['val'].fillna(df['val'].median())

    df = remove_outliers_iqr(df, 'val')

    df['date'] = pd.to_datetime(df['timestamp']).dt.date

    for date_chunk, chunk_df in df.groupby('date'):
        out_buffer = BytesIO()
        chunk_df.to_parquet(out_buffer, index=False)
        out_buffer.seek(0)

        s3_key = f"telemetry/year={date_chunk.year}/month={date_chunk.month}/day={date_chunk.day}/data.parquet"
        s3_client.put_object(Bucket=BUCKET_NAME, Key=s3_key, Body=out_buffer.getvalue())


if __name__ == "__main__":
    extract_incremental_telemetry()