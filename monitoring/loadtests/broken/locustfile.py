import json

from locust import HttpLocust, TaskSet, task


class UserBehavior(TaskSet):
    @task(1)
    def index(self):
        self.client.post("/broken")
        payload = {'some':'payload'}
        headers = {'content-type': 'application/json'}
        self.client.post("/broken", data=json.dumps(payload), headers=headers, catch_response=True)


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 8000
