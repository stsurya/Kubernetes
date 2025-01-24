## What is probe ?

In Kubernetes, a probe is essentially a diagnostic check performed by the kubelet (the agent running on each Kubernetes node) to determine the health and status of a container. Think of it as a "health test" for your application running inside a container.

The probe checks whether the container is:

- Alive (Liveness Probe) – Determines if the container is still running.
- Ready (Readiness Probe) – Determines if the container is ready to accept traffic.
- Starting Up (Startup Probe) – Determines if the container has successfully started (useful for slow-starting applications).

## What is Libeness probe ?

A liveness probe in Kubernetes is a mechanism used to determine if a container is still running and functioning properly. If the liveness probe fails, Kubernetes will restart the container to ensure that the application stays healthy and available.

```
apiVersion: v1
kind: Pod
metadata:
  name: liveness-example
spec:
  containers:
  - name: my-container
    image: my-app-image
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 5
```

**Explanation:**

- httpGet: The probe sends an HTTP GET request to /healthz on port 8080.
- initialDelaySeconds: The probe waits 3 seconds after the container starts before running the first check.
- periodSeconds: The probe checks the container every 5 seconds.
