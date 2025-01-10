## Deployments

A deployment provides declarative updates for pods and replica sets.

You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate.You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

- In Kubernetes a deployment is a method of launching a pod with containerized applications and ensuring that the necessary number of replicas is always running on the cluster.

## How Deployment works ?

**Declarative Updates:** You specify the desired state of your application in a Deployment YAML manifest, including the number of replicas, container images, and labels. Kubernetes ensures the actual state matches this desired state.

**ReplicaSet Management:** A Deployment creates and manages ReplicaSets, which in turn manage the Pods. It ensures the correct number of Pods are running at any time.

**Rolling Updates:** Deployments support rolling updates, allowing you to update applications with zero downtime by incrementally replacing old Pods with new ones.

**Rollback:** If a Deployment update fails, you can easily roll back to a previous version using kubectl rollout undo.

- When a deployment is happening a new replica set will be created and pods are created in new replic set and old replica set will be retained to rollback.
