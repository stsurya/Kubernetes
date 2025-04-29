## Ingress

- Ingress defines how to route external traffic to Internal services.

- Ingress controller is the component that enforces and acts on the ingress rules. Without ingress controller ingress rules are ignored.

- Centralized traffic management, TLS, routing, cost savings.

**Use LoadBalancer Service:**

- When you need to expose a single service directly to external traffic.

- For non-HTTP services or when simplicity is preferred.​

**Use Ingress:**

- When you have multiple HTTP/HTTPS services to expose.

- To consolidate access through a single external IP and manage routing centrally.

- When you require advanced features like SSL termination, path-based routing, or virtual hosting.​
