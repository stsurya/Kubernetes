### Why we need Services ?

Pods are ephimeral in nature. Each and every pod will be having a unique IP address, if suppose there are two pods A(172.40.30.1) and B(172.40.30.2). A is getting some data from B, and B pod goes down for some reason, but due to the auto-healing capacity which is provided by the replicasets a new pod will be created but with different IP address i.e., 172.40.30.3. Here comes the problem, how will A know the new ip address and how can it fetch the data from B ??

Now we're entering into Services.

### What are Kubernetes Services ?

Since pods are ephemeral, a service enables a group of pods, which provide specific functions (web services, image processing, etc.) to be assigned a name and unique IP address (clusterIP). As long as the service is running that IP address, it will not change.

### What are the types of Kubernetes services?

- **ClusterIP**: A Cluster IP service is the default type of service in kubernetes. It creates a service inside the kubernetes cluster, which can be accessed by the other applications in cluster, without allowing external access.

- **NodePort**: A NodePort service opens a specific port on all the Nodes in the cluster, and any traffic sent to that port is forwarded to the service. The service cannot be accessed from the cluster IP.

- **LoadBalancer**: A LoadBalancer is a standard way to expose a Kubernetes service externally so it can be accessed over the internet. If you are using AKS, this creates a Network Load Balancer with one IP address, which external users can access and are then forwarded to the relevant node in your Kubernetes cluster. A LoadBalancer can also be accessed in the same way as a ClusterIP or NodePort.
