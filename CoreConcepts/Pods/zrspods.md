```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: zone-aware-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: topology.kubernetes.io/zone
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: myapp
      containers:
      - name: myapp
        image: nginx
```

- Kubernetes uses the topology.kubernetes.io/zone label to automatically distribute pods in a replication controller or service across the various available zones available.

- The maxSkew parameter describes the degree to which pods might be unevenly distributed. Assuming three zones and three replicas, setting this value to 1 ensures that each zone has at least one pod running:
