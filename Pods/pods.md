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

## What is the difference between pods and containers ?

Scope: A container is focused on a single application or service, while a Pod is a higher-level abstraction that can include multiple containers, allowing them to share resources and run together.
Lifecycle: Containers can run independently in any environment with a container runtime, whereas Pods are specifically managed by Kubernetes.
Networking: Containers within the same Pod share the same network namespace, IP address, and ports, making communication between them more efficient. Containers in different Pods have separate IP addresses.

## Errors while creating pods

- "CrashLoopBackOff"
- "ImagePullBackOff"

## Can you explain the concept of Pod lifecycle? What are the different phases?

The Pod lifecycle refers to the various stages a Pod goes through from creation to deletion in a Kubernetes cluster.

**1. Pending:** The Pod is created and accepted by the Kubernetes cluster, but not yet running. This is the initial state.

**2. Running:** The Pod is running and at least one container is in the running state.

**3. Succeeded:** All containers in the Pod have successfully completed their execution and exited.

**4. Failed:** One or more containers in the Pod have failed, and the Pod is no longer running.

**5. Unknown:** The Pod's state cannot be determined, often due to a network issue or node failure.
