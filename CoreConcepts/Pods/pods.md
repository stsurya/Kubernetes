# Pod

A Pod is the smallest unit of kubernetes. A pod can encapsulates one or more containers.Pods are ephemeral by nature, if one pod goes down, if a pod goes down(or fails on the node) kubernetes can automatically create a replica of pod to continue the operations smoothly.

## YAML(Pods with YAML) in kubernetes

For every YAML file in kubernetes there are four root level properties they're apiVersion, Kind, metadata, spec

- **apiVersion:** This is the version of k8s API to create the object. Depending on what you create you can pick your version.
- **kind:** It refers to the type of object that we create.
- **metadata:** This is the data about object. Eg: Names and labels they're like siblings indentation is important here.
- **spec:** This is where we provide additional information depending on what object we're going to create.

```
apiVersion: v1
kind: Pod
metadata:
    name: nginx
    labels:
        app: nginx
        tier: frontend
spec:
    containers:
    - name: nginx
      image: nginx
    - name: busybox
      image: busybox
```

```
kubectl apply -f pod.yml --> create pod
kubectl get pods --> Gives details of pods
kubectl get pods -o wide --> Gives bit more detailed information.
kubectl describe pod <podname> --> Detailed descritpion of a pod
kubectl delete pod <podname> --> will delete the pod
kubectl run <pod-name> --image=<image-name>
kubectl get pods --field-selector=status.phase=Pending
```

## Best pracitce to have only one container in one pod

While it's technically possible to have multiple containers in a single pod, there are good reasons why having one container per pod is considered a best practice:

1. Coupling: Containers in the same pod are tightly coupled, making it harder to manage and scale individual components.
2. Resource sharing: Containers share resources like CPU, memory, and network, which can lead to resource contention and performance issues.
3. Isolation: Containers in the same pod share the same network namespace, making it harder to isolate and secure individual components.
4. Scalability: Scaling a pod with multiple containers can lead to uneven scaling, where some containers are over-provisioned while others are under-provisioned.
5. Debugging: With multiple containers in a pod, debugging becomes more complex, as logs and errors are intertwined.
6. Security: Having multiple containers in a pod increases the attack surface, as a vulnerability in one container can affect others.
7. Kubernetes management: Kubernetes provides features like rolling updates, self-healing, and resource management, which are more effective with one container per pod.

That being said, there are valid use cases for multiple containers in a pod, such as:

1. Sidecar containers: Supporting containers that enhance the main container, like logging or monitoring agents.
2. Init containers: Containers that run before the main container, like initialization scripts.
3. Admission controllers: Containers that enforce policies or modify requests before they reach the main container.

In summary, while it's possible to have multiple containers in a pod, having one container per pod is generally recommended for better manageability, scalability, and isolation. However, there are exceptions, and understanding the trade-offs is essential.

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

## Deploying pods on control plane nodes is not recommended for several reasons:

1. Resource contention: Control plane nodes are responsible for managing the cluster, and running pods on them can consume resources (CPU, memory, etc.) that are critical for cluster management.
2. Security: Control plane nodes have elevated privileges, and running pods on them can increase the attack surface. If a pod is compromised, it could potentially gain access to sensitive cluster resources.
3. Stability: Control plane nodes are critical for cluster stability. If a pod running on a control plane node causes issues, it can impact the entire cluster.
4. Scalability: Control plane nodes are typically not designed for running large workloads. Deploying pods on them can limit the scalability
