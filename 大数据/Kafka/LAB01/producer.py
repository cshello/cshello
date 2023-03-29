from kafka import KafkaProducer
from faker import Faker
import json
from time import sleep

producer = KafkaProducer(bootstrap_servers='localhost:9092')
_instance = Faker()

for _ in range(20):
    _data = {
        "first_name": _instance.first_name(),
        "city": _instance.city(),
        "phone_number": _instance.phone_number(),
        "state": _instance.state(),
        "id": str(_)
    }
    _payload = json.dumps(_data).encode("utf-8")
    response = producer.send('FirstTopic', _payload)
    print(response, f"msg: {_payload}")

    sleep(2)
