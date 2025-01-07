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
