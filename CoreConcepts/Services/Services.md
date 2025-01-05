## Services

A kubernetes service is a logical abstraction for a deployed group of pods in a cluster. Since pods are ephemeral, a service enables a group of pods, to be assigned a name and unique IP address (clusterIP). As long as the service is running that IP address, it will not change.

### What are the types of Kubernetes services?

**ClusterIP.** Exposes a service which is only accessible from within the cluster.

**NodePort.** Exposes a service via a static port on each node’s IP.

**LoadBalancer.** Exposes the service via the cloud provider’s load balancer.

## NodePort

- A NodePort service is the most primitve way to get the external traffic directly to your service. NodePort, as the name implies, opens a specific port on all the Nodes, and any traffic that is sent to this port is forwarded to the service.

![Image Misssing](./NodePort.webp)

```
apiVersion: v1
kind: Service
metadata:
  name: my-nodeport-service
spec:
  selector:
    app: my-app
  type: NodePort
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30036
    protocol: TCP
```

### Key Components of NodePort:

- **Selector:** Identifies the Pods that the service should target.
- **NodePort:** The port that is exposed on the Node.
- **TargetPort:** The port on the Pod where the application is running.
- **Port:** The port of the ClusterIP service.

- By default, Kubernetes reserves a port range 30000–32767 for NodePort services. If you don’t specify this port, it will pick a random port. Most of the time you should let Kubernetes choose the port; there are many caveats to what ports are available for you to use.<br>

There are many downsides to this method:<br>

- You can only have one service per port.<br>
- You can only use ports 30000–32767.<br>
- If your Node/VM IP address change, you need to deal with that.<br>

- If pods are running on multiple nodes, a single service can still route traffic to all the pods because it selects them based on matching labels.<br>
