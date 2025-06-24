# Metrics Server

- It's a core component that collects CPU and memory metrics from kubelets and exposes them through the Kubernetes API server via the Metrics API.
- Metrics Server runs as a deployment in the kube-system namespace. It communicates with kubelets on each node using the kubelet's secure port (10250).
- **The data flow is:** Container → cAdvisor → kubelet → Metrics Server → Kubernetes API Server → Client (kubectl, HPA, etc.)
- Metrics Server stores only the latest metrics in memory - it doesn't persist historical data. For historical metrics and monitoring, you need additional tools like Prometheus.

Technical Implementation Questions
Q: How would you troubleshoot a scenario where kubectl top nodes returns "error: Metrics API not available"?<br>
Expected Answer: Check if Metrics Server is running (kubectl get pods -n kube-system | grep metrics-server), verify its logs for connection issues with kubelets, check network policies that might block communication, and ensure proper RBAC permissions. Also verify kubelet configuration and cAdvisor functionality.<br>
Q: Explain the difference between Metrics Server and Prometheus for monitoring in Kubernetes.<br>
Expected Answer: Metrics Server provides real-time resource metrics (CPU/memory) primarily for autoscaling and kubectl top commands. It stores only current data in memory. Prometheus is a full monitoring solution that stores historical time-series data, supports custom metrics, alerting, and complex queries. They serve different purposes and often complement each other.
Q: You have an HPA that's not scaling your application despite high CPU usage. How would you investigate?<br>
Expected Answer: First check if Metrics Server is running and healthy. Verify HPA configuration with kubectl describe hpa. Check if metrics are available with kubectl top pods. Examine HPA status and current metrics. Look at deployment resource requests (HPA needs these defined). Check for any resource quotas or limits preventing scaling.
Architecture and Design Questions
Q: In a multi-tenant Kubernetes cluster, how would you ensure Metrics Server performs well under high load?<br>
Expected Answer: Configure appropriate resource requests/limits for Metrics Server, consider horizontal scaling if supported, tune scraping intervals, implement proper monitoring of Metrics Server itself, optimize kubelet configuration, and possibly use node selectors to run Metrics Server on dedicated nodes.
Q: How does Metrics Server handle node failures or network partitions?<br>
Expected Answer: Metrics Server will lose connectivity to affected nodes and won't receive metrics from them. It will continue serving metrics for healthy nodes. The unavailable nodes' metrics will become stale and eventually time out. HPA and other consumers need to handle missing metrics gracefully.
Security and Operations Questions
Q: What security considerations should you keep in mind when deploying Metrics Server?<br>
Expected Answer: Use TLS for kubelet communication (avoid --kubelet-insecure-tls in production), implement proper RBAC with least privilege principle, secure the Metrics API endpoint, consider network policies to restrict access, and regularly update Metrics Server to patch security vulnerabilities.
Q: How would you monitor the health and performance of Metrics Server itself?<br>
Expected Answer: Monitor Metrics Server pods' resource usage, check response times of metrics API calls, set up alerts for Metrics Server pod failures, monitor kubelet connectivity issues in logs, track metrics API availability, and implement health checks.
Advanced Troubleshooting
Q: Describe a scenario where Metrics Server shows different CPU usage than what you see in your monitoring tool, and how you'd investigate.<br>
Expected Answer: Different tools may sample at different intervals or use different calculation methods. Check the time windows being compared, understand how each tool calculates averages, verify if there are any time synchronization issues, and check if there are differences in metric collection methods (cAdvisor vs other agents).
