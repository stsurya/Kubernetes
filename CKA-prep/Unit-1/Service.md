# Service

A Service is a resource that map network traffic to the Pods in your cluster. You need to create a service each time you expose a set of pods over the network, whether within your cluster or externally.

kubectl expose pod redis --port=6379 --name=redis-service
