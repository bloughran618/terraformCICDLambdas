import requests


def lambda_handler(event, context):
    message = f"Have fun at Friendsgiving {event.get('key1')}!"
    return {
        "message": message
    }
