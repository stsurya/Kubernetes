## What is POD ?

- Pods are the smallest deployable units in kubernetes. A pod is a group of one or more containers, with shared storage and network resources.
- Grouping them in this way allows them to communicate with each other as they've shared same physical hardware, while still remaining isolated to some degree.
- When conatainers are organized into pods, kubernetes can use replication controllers to horizontally scale an application as needed. In effect, it means that whenever a pod is down Kubernetes can automatically replicate it and deploy it to the cluster.
