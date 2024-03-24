### Why we need Services ?

Pods are ephimeral in nature. Each and every pod will be having a unique IP address, if suppose there are two pods A(172.40.30.1) and B(172.40.30.2). A is getting some data from B, and B pod goes down for some reason, but due to the auto-healing capacity which is provided by the replicasets a new pod will be created but with different IP address i.e., 172.40.30.3. Here comes the problem, how will A know the new ip address and how can it fetch the data from B ??

Now we're entering into Services.

### What are Kubernetes Services ?
