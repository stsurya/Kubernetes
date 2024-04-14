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

Similar patter is followed whenever a change request comes in.
