# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

import time as t
import json
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient

# Define ENDPOINT, CLIENT_ID, PATH_TO_CERTIFICATE, PATH_TO_PRIVATE_KEY, PATH_TO_AMAZON_ROOT_CA_1, MESSAGE, TOPIC, and RANGE
class Publisher:
	def __init__(self, cognitoID):
		self.ENDPOINT = "a30e2r8knzv4ds-ats.iot.us-east-2.amazonaws.com"
		self.CLIENT_ID = "JetsonNano1"
		self.PATH_TO_CERTIFICATE = "/home/mainacc/objectDetectAWS/certs/JetsonNano1.cert.pem"
		self.PATH_TO_PRIVATE_KEY = "/home/mainacc/objectDetectAWS/certs/JetsonNano1.private.key"
		self.PATH_TO_AMAZON_ROOT_CA_1 = "/home/mainacc/objectDetectAWS/certs/root-CA.crt"

		self.TOPIC = "JetsonNano1/{}".format(cognitoID)
		print("Topic set to {}".format(self.TOPIC))

		self.myAWSIoTMQTTClient = AWSIoTMQTTClient(self.CLIENT_ID)
		print("IoT MQTT client instantiated: {}".format(self.CLIENT_ID))

	def connect_client(self):
		print(self.ENDPOINT)
		print(self.PATH_TO_AMAZON_ROOT_CA_1)
		self.myAWSIoTMQTTClient.configureEndpoint(self.ENDPOINT, 8883)
		self.myAWSIoTMQTTClient.configureCredentials(self.PATH_TO_AMAZON_ROOT_CA_1, self.PATH_TO_PRIVATE_KEY, self.PATH_TO_CERTIFICATE)
		self.myAWSIoTMQTTClient.connect()
		print("Client connected...")

	def publish_data(self, msg):
		print('Begin Publish')
		message = json.dumps(msg)
		self.myAWSIoTMQTTClient.publish(self.TOPIC, message, 1) 
		print("Published: '" + json.dumps(message) + "' to the topic: " + self.TOPIC)

	def disconnect_client(self):
		print('Publish End')
		self.myAWSIoTMQTTClient.disconnect()
		print('Disconnected successfully')

