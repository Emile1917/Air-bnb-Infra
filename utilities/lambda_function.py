# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
import json
import urllib.parse
import boto3
import pandas as pd
from io import BytesIO


print('Loading function')

s3 = boto3.client('s3')



def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    print(key)
    print(key.replace(key[key.find('.'):], '.json'))
    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        if response['ContentType'] != 'text/json':
            result = response['Body'].read()
            df = pd.read_csv(BytesIO(result)) if response['ContentType'] == 'text/csv' else  pd.read_csv(BytesIO(result), compression='gzip') if response['ContentType'] == 'application/x-gzip'  else pd.read_csv(BytesIO(result)) if response['ContentType'] == 'binary/octet-stream' else pd.DataFrame()
            df_10 = df.head(10)
            print(df_10)
            print("CONTENT TYPE: " + response['ContentType'])
            s3.put_object(
            Bucket=bucket,     # Replace with your bucket name
            Key=key.replace(key[key.find('.'):], '.json'),
            Body=df.to_json(index=False,orient='records').encode()
            )
            return response['ContentType']
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e
              
