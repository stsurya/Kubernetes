## How a Scheduler works ?

**1 . Pods Creation:**

- A User or controller(Replica Set or Deployment) creates a pod.<br>
- The pod starts in pending state.<br>

**2. Scheduler Watches for Pending Pods:**

- The scheduler continuously watches the Kubernetes API for pods that have no node assigned (spec.nodeName is empty).<br>

**3. Scoring Nodes**

- The scheduler scores all suitable nodes to find the best node for the pod, based on a scoring algorithm.<br>

**4. Binding the Pod to a Node**

- Once the scheduler selects a node, it binds the pod to the node by updating the pod's status in the API server.

## ManualScheduling

- You can assign a specific node for your pod using the nodeName field in the pod's manifest.<br>

```
apiVersion: v1
kind: Pod
metadata:
  name: manual-schedule-pod
spec:
  containers:
  - name: nginx
    image: nginx
  nodeName: <node-name>  # Replace <node-name> with the name of the target node
```

- Replace `node-name` with the name of the desired node.
- Kubernetes will not use the scheduler to place this pod; it will directly assign it to the specified node.
- The above yaml will only work while creation of pod.
- If incase there is a pod which is already up and running and if you want to pace it on particualr node. k8s won't allow you to modify the `nodeName` property of a pod.
- Easiest way is to delete pods and re-create or else You can do that via binding and followd by post request.
