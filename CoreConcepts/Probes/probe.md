## What is probe ?

In Kubernetes, a probe is essentially a diagnostic check performed by the kubelet (the agent running on each Kubernetes node) to determine the health and status of a container. Think of it as a "health test" for your application running inside a container.

The probe checks whether the container is:

- Alive (Liveness Probe) – Determines if the container is still running.
- Ready (Readiness Probe) – Determines if the container is ready to accept traffic.
- Starting Up (Startup Probe) – Determines if the container has successfully started (useful for slow-starting applications).
