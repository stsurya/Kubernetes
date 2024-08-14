## Services

A kubernetes service is a logical abstraction for a deployed group of pods in a cluster. Since pods are ephemeral, a service enables a group of pods, to be assigned a name and unique IP address (clusterIP). As long as the service is running that IP address, it will not change.

### What are the types of Kubernetes services?

**ClusterIP.** Exposes a service which is only accessible from within the cluster.

**NodePort.** Exposes a service via a static port on each node’s IP.

**LoadBalancer.** Exposes the service via the cloud provider’s load balancer.
