import requests


def lambda_handler(event, context):
    message = f"Hello {event.get('key1')}!"
    return {
        "message": message
    }
