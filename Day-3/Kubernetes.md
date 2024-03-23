## What is POD ?

- Pods are the smallest deployable units in kubernetes. A pod is a group of one or more containers, with shared storage and network resources.
- Grouping them in this way allows them to communicate with each other as they've shared same physical hardware, while still remaining isolated to some degree.
- When conatainers are organized into pods, kubernetes can use replication controllers to horizontally scale an application as needed. In effect, it means that whenever a pod is down Kubernetes can automatically replicate it and deploy it to the cluster.

### how to create a pod ?

- Write an yaml file as pods.yml
- Run the command kubectl apply -f pods.yml

to see the existing pods use

```
kubectl get pods
```

to get the ip address or other details of pods use

```
kubectl get pods -o wide
```

if you want to see continuous stream of logs for pods use

```
kubectl get pods -w
```

to delete the pods

```
kubectl delete pod <pod-name>
```

## What is Replica Set ?

Replica set is a kubernetes resource which is reponsible for maintaing a specified number of identical pods all the time. ReplicaSet automatically detect and recover from pods failures by creating new replicas to replace the failed ones, ensuring that the desired state of the application is maintained. This is called self-healing or auto-healing.

### how to create a pod ?

- Write an YAML file as Deployments.yml
- Run the command kubectl apply -f Deployments.yml

to see the existing replica set(rs) use

```
kubectl get deploy
```

Try it: Try to delete a pod and see the list of pods again, the replica set will always create an new pod when a deletion of pod happens
