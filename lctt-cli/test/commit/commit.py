class Vector():
    def __init__(self, rabbit=None):
        self.rabbit='11111111'

    def test(self,rabbit=None):
        rabbit=self.rabbit
        return rabbit

print(Vector().test())

