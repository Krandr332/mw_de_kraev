import pandas as pd
import numpy as np


def verify_data_quality(df: pd.DataFrame, target_column: str, max_null_ratio: float = 0.05) -> bool:
    if df.empty:
        return False

    null_ratio = df[target_column].isnull().mean()
    if null_ratio > max_null_ratio:
        return False

    return True


def remove_outliers_iqr(df: pd.DataFrame, column: str) -> pd.DataFrame:
    q1 = df[column].quantile(0.25)
    q3 = df[column].quantile(0.75)
    iqr = q3 - q1
    lower_bound = q1 - 1.5 * iqr
    upper_bound = q3 + 1.5 * iqr
    return df[(df[column] >= lower_bound) & df[column] <= upper_bound]