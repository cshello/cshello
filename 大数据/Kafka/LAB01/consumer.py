import kafka
from kafka import KafkaConsumer

import json
import requests
import os
import sys


def main():
    print("Listening *****************")

    consumer = KafkaConsumer("FirstTopic")

    for msg in consumer:
        payload = json.loads(msg.value)
        payload["meta_data"] = {
            "topic": msg.topic,
            "partition": msg.partition,
            "offset": msg.offset,
            "timestamp": msg.timestamp,
            "timestamp_type": msg.timestamp_type,
            "key": msg.key,
        }
        print(payload, end="\n")


if __name__ == '__main__':
    main()
