## Deployments

A deployment provides declarative updates for pods and replica sets.

You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate.You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

- In Kubernetes a deployment is a method of launching a pod with containerized applications and ensuring that the necessary number of replicas is always running on the cluster.

## How Deployments Handle ReplicaSets

**New ReplicaSet Creation:**

When you update a Deployment (e.g., updating the container image or other spec fields), Kubernetes creates a new ReplicaSet for the updated Deployment.

**Old ReplicaSet Scaling:**

During the rollout, Kubernetes gradually reduces the number of replicas in the old ReplicaSet and increases the replicas in the new ReplicaSet based on the Deployment's strategy (e.g., rolling update).

**Old ReplicaSet Retention:**
After the rollout is complete, the old ReplicaSet is retained, but it is typically scaled down to 0 replicas.
Kubernetes retains these old ReplicaSets as part of its Deployment's revision history, allowing you to roll back to a previous version if needed.

**Cleanup of Old ReplicaSets:**
Old ReplicaSets are only deleted if you explicitly clean up the Deployment's revision history or the number of retained revisions exceeds the configured limit.
