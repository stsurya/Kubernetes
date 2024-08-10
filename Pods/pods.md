## What is POD ?

- Pods are the smallest deployable units in kubernetes. A pod is a group of one or more containers, with shared storage and network resources.
- Grouping them in this way allows them to communicate with each other as they've shared same physical hardware, while still remaining isolated to some degree.
- When conatainers are organized into pods, kubernetes can use replication controllers to horizontally scale an application as needed. In effect, it means that whenever a pod is down Kubernetes can automatically replicate it and deploy it to the cluster.

## What is the purpose of pods ?

i) Simplified Management: Pods provide a single unit of management for multiple containers, making it easier to deploy, scale, and update applications.
ii) Shared Resources: Pods share networking, storage, and compute resources among containers, improving resource utilization and efficiency.
iii) Automatic Restarts and Rolling Updates: Pods enable Kubernetes to automatically restart or replace failed containers and enable rolling updates for seamless application updates.
iv) Logical Isolation and Security: Pods provide logical isolation between applications and enable Kubernetes to enforce security policies and network policies, improving security and isolation.

To create a pod

```
kubectl run <pod-name> --image=<image-name>
```
