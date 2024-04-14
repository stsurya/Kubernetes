# What is ETCD ?

ETCD is a distributed reliable key-value store that is simple, secure and Fast.

- ETCD stores the information regarding the clsuters such as node, pods, secrets, accounts and other.
- whenever you run a kube control get command, you get the details from ETCD server.
- Any change such as adding nodes, deploying pods is considedred to be completed when it is updated in ETCD server.
- ETCD listens 2739 it's a default port.

# Kube-API Server:

This is the primary management component in Kubernetes.

- whenever a request comes from kube control command, for example, to create a pod first it reachs out to a kube-api server and kube-api server will authenticate it.
- After that it creates a pod without assigoning it to any node and updates it in the etcd server and respond back to client that a pod is created.
- Kube-scheduler will always keep on monitoring kube-api, when it creates a pod without assigning a node. kube-scheduler will indentify a node for the pod and communicates back to kube-api server.
- Then kube-api server will update those details from kube-scheduler and stores them ETCD server.
- Kube-api server also communicates with the kubelet on the resective node. Then the kubelet will create a pod and deploy the image and update back to the kube-api server.

Similar pattern is followed whenever a change request comes in.

# Kube Controller Manager:

- Simply, Kube Controller Manager means it'll continuosly monitor the various componets in the system and work towards bringing the whole system to the desired state.
- In the background it'll run various other controllers such as replica controller, node controller.
- For eg: Node Controller will always monitor all the nodes, Node Controller will check the health of nodes every 5seconds through kube-api server. When ever it doesn't receive any update from nodes it'll wait for 40sec and then it will mark node as un-reachable. Node-controller will give 5min to the node to comeback if it doesn't comeback then node-controller will create a new node.

# Kube Scheduler:

- The scheduler is responsible for deciding which pod goes on which node. It doesn't actually place the pod on the node, It's the job of kubelet.
- kubelet actually creates the pod on the node.
- We can customize the Kube-scheduler as well.

# Kubelet:

The main service on a node, regularly taking in new or modified pod specifications(primarly from the kube-apiserver) and ensuring that their pods and containers are running in the desired state.This component also reports to the master on the health of the host where it is running.

# Kube Proxy:

Its main function is to ensure smooth communication between services and pods within the cluster.
