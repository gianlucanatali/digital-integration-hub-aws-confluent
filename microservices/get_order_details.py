import boto3
from boto3.dynamodb.conditions import Key, Attr


def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    
    table = dynamodb.Table('orders-details-joined')
    
    fe = Attr('customer_id').eq(event['customer_id'])
    response = table.scan(
        FilterExpression=fe        
    )
    items = response['Items']
    return items;