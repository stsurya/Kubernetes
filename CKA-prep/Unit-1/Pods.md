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
