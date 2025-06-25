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

Absolutely, Surya! Here are **concise interview-style notes** for:

* **StorageClass**
* **PersistentVolumeClaim (PVC)**
* **PersistentVolume (PV)**

---

## 📘 Kubernetes Storage: Quick Notes

---

### 🔹 1. **StorageClass**

> **Definition**: A Kubernetes object that defines **how to provision storage dynamically** using a specific backend like Azure Disk, AWS EBS, etc.

**Purpose**:

* Automates disk creation when a PVC requests storage.
* Abstracts cloud-specific volume details.

**Key Fields**:

* `provisioner`: CSI driver (e.g., `disk.csi.azure.com`)
* `parameters`: Disk type, performance tier (e.g., `skuName: Premium_LRS`)
* `reclaimPolicy`: What happens to volume after PVC is deleted (`Retain` or `Delete`)
* `volumeBindingMode`: When to bind PVC (`Immediate` or `WaitForFirstConsumer`)

**Example**:

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: managed-csi-premium
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

---

### 🔹 2. **PersistentVolumeClaim (PVC)**

> **Definition**: A request by a pod for a specific amount and type of storage.

**Purpose**:

* Allows pods to claim storage dynamically (via StorageClass) or bind to existing PVs.
* Abstracts the actual disk away from the application.

**Key Fields**:

* `accessModes`: ReadWriteOnce, ReadOnlyMany, etc.
* `resources.requests.storage`: e.g., 10Gi
* `storageClassName`: Name of the StorageClass to use

**Example**:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongo-data
spec:
  accessModes: [ "ReadWriteOnce" ]
  storageClassName: managed-csi-premium
  resources:
    requests:
      storage: 10Gi
```

---

### 🔹 3. **PersistentVolume (PV)**

> **Definition**: The **actual physical or virtual disk** that fulfills a PVC.

**Purpose**:

* Represents a piece of storage in the cluster
* Can be pre-created (static) or created dynamically by a StorageClass

**Key Fields**:

* `capacity.storage`: Actual size of the volume
* `accessModes`: Must match PVC
* `persistentVolumeReclaimPolicy`: Retain/Delete
* `storageClassName`: Matches the class that provisioned it
* `claimRef`: Shows which PVC is using it

**Status**:

* `Available`: Not bound to any PVC
* `Bound`: Linked to a PVC

---

### 📌 Real-world Flow

```
Pod → requests PVC → Kubernetes uses StorageClass → provisions PV → mounts it to Pod
```

---

### ✅ Interview Summary

* **StorageClass** = How the storage is created (template).
* **PVC** = A request for storage made by the pod.
* **PV** = The actual provisioned storage fulfilling the request.

---