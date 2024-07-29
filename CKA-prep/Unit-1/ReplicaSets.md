# Replica Sets

A Replica set's purpose is to maintain a stable set of replica pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-replicaset
  labels:
    app: guestbook
    tier: frontend
spec:
    replicas: 3
    selector:
        matchLabels:
            tier: my-app
    template:
        labels:
            tier: frontend
        spec:
            containers:
            - name: php-redis
              image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5
```

### You can scale replica sets using below commands

**kubectl replace -f replicasets.yml**
**kubectl scale replicas=6 -f replicasets.yml**
