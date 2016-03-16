import json
from unittest import TestCase
import app

class QuestionTestCase(TestCase):
    def setUp(self):
        self.app = app.app.test_client()

    def test_newquestion(self):
        self.fail()