## What is Replica Set ?

Replica set is a kubernetes resource which is reponsible for maintaing a specified number of identical pods all the time. ReplicaSet automatically detect and recover from pods failures by creating new replicas to replace the failed ones, ensuring that the desired state of the application is maintained. This is called self-healing or auto-healing.

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
