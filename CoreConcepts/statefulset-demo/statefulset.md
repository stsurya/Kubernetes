## What is StatefulSet in k8s ?

In kubernetes stateful set is a workload API object used to manage the stateful applications. Unlike Deployments and ReplicaSets, Stateful sets maintain an unique identity for each of it's pods and this is used when you need

- Stable, unique network indentifiers for each pod.
- Stable, persistent storage attached to each pod.
- Ordered, graceful deployment, scaling, deletion of pods.

## 🔧 Key Characteristics of StatefulSets:

- **Stable Pod Name:** Each Pod gets a unique, stable name like podname-0, podname-1, etc.
- **Stable Storage** Each Pod gets a PersistentVolumeClaim (PVC) that is not deleted when the Pod is deleted.
- **Ordered Operations** Pods are created, scaled, and deleted in order. Eg: pod-1 won’t start until pod-0 is ready.
- **Sticky Identity** Even if a Pod is deleted, a new Pod with the same name is created in its place with the same volume.

## 📦 Common Use Cases:

- **Databases:** MySQL, PostgreSQL.

- **Distributed systems:** Kafka, Zookeeper, Elasticsearch.

- Applications where each instance maintains its own state/data

🎯 Every time you use a StatefulSet, you should create a Headless Service (clusterIP: None) for it to function correctly — especially for stateful, peer-based systems.

```
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  clusterIP: None  # Makes it a headless service
  selector:
    app: nginx
  ports:
  - name: web
    port: 80
    targetPort: 80
```

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nginx
spec:
  serviceName: "nginx" # Must match the headless service
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
      storageClassName: default  # Replace with your storage class if needed
```
