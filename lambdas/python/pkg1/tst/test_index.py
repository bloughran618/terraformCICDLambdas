import unittest
from unittest.mock import MagicMock

from lambdas.python.pkg1.src.index import lambda_handler


class TestLambdaHandler(unittest.TestCase):

    def test_lambda_handler_empty(self):
        event = {}
        context = MagicMock()

        result = lambda_handler(event, context)

        self.assertEqual(result["message"], "Hello None!")

    def test_lambda_handler_returns_hello_lambda_body(self):
        event = {"key1": "Brian"}
        context = MagicMock()

        result = lambda_handler(event, context)

        self.assertEqual(result["message"], "Hello Brian!")


if __name__ == "__main__":
    unittest.main()