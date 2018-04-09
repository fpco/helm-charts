from locust import HttpLocust, TaskSet, task


class UserBehavior(TaskSet):
    @task(1)
    def index(self):
        self.client.get("/sleep")


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 15000
    max_wait = 20000
