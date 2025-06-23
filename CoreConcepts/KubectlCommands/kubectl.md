Here's a **comprehensive list of important `kubectl` commands** with **brief explanations**

---

## 🔧 **1. Cluster Information & Configuration**

| Command                                     | Description                                            |
| ------------------------------------------- | ------------------------------------------------------ |
| `kubectl version`                           | Displays the client and server versions of Kubernetes. |
| `kubectl cluster-info`                      | Shows cluster's master and services URLs.              |
| `kubectl config view`                       | Shows kubeconfig settings (contexts, clusters, users). |
| `kubectl config get-contexts`               | Lists available contexts in kubeconfig.                |
| `kubectl config use-context <context-name>` | Switches between clusters/contexts.                    |
| `kubectl config current-context`            | Displays the current context in use.                   |

---

## 📦 **2. Working with Resources (Pods, Deployments, etc.)**

| Command                              | Description                                                    |
| ------------------------------------ | -------------------------------------------------------------- |
| `kubectl get pods`                   | Lists all pods in the current namespace.                       |
| `kubectl get pods -n <namespace>`    | Lists pods in a specific namespace.                            |
| `kubectl get all`                    | Lists all resources (pods, svc, deployments) in the namespace. |
| `kubectl get deployment`             | Lists deployments in the current namespace.                    |
| `kubectl get svc`                    | Lists services.                                                |
| `kubectl describe pod <pod-name>`    | Shows detailed pod information (events, containers, etc.).     |
| `kubectl describe deployment <name>` | Details of a deployment.                                       |
| `kubectl get nodes`                  | Lists nodes in the cluster.                                    |
| `kubectl describe node <node-name>`  | Node details (conditions, resource alloc, etc.).               |

---

## 📄 **3. Create, Apply, Delete Resources**

| Command                            | Description                                                  |
| ---------------------------------- | ------------------------------------------------------------ |
| `kubectl apply -f <file>.yaml`     | Creates or updates resources from YAML.                      |
| `kubectl create -f <file>.yaml`    | Creates resources from a manifest (fails if already exists). |
| `kubectl delete -f <file>.yaml`    | Deletes resources defined in the YAML file.                  |
| `kubectl delete pod <name>`        | Deletes a specific pod.                                      |
| `kubectl delete deployment <name>` | Deletes a deployment.                                        |

---

## ⚙️ **4. Editing and Patching**

| Command                                                        | Description                                          |
| -------------------------------------------------------------- | ---------------------------------------------------- |
| `kubectl edit pod <name>`                                      | Opens live pod config in editor (vi), apply on save. |
| `kubectl patch deployment <name> -p '{"spec":{"replicas":3}}'` | Updates only a part of the deployment (in-place).    |

---

## 🚀 **5. Rollouts & Scaling**

| Command                                        | Description                                         |
| ---------------------------------------------- | --------------------------------------------------- |
| `kubectl scale deployment <name> --replicas=3` | Scales a deployment to the specified replica count. |
| `kubectl rollout status deployment/<name>`     | Shows rollout progress of a deployment.             |
| `kubectl rollout history deployment/<name>`    | Shows deployment revision history.                  |
| `kubectl rollout undo deployment/<name>`       | Reverts deployment to previous version.             |

---

## 🧪 **6. Debugging & Logs**

| Command                              | Description                                            |
| ------------------------------------ | ------------------------------------------------------ |
| `kubectl logs <pod>`                 | Shows logs of the pod's main container.                |
| `kubectl logs <pod> -c <container>`  | Logs of a specific container in the pod.               |
| `kubectl logs -f <pod>`              | Follows logs in real-time.                             |
| `kubectl exec -it <pod> -- bash`     | Opens an interactive shell into the pod.               |
| `kubectl port-forward <pod> 8080:80` | Forwards local port 8080 to pod port 80.               |
| `kubectl attach <pod>`               | Attaches your terminal to a running container process. |

---

## 📥 **7. Resource Output Formats**

| Command                        | Description                        |
| ------------------------------ | ---------------------------------- |
| `kubectl get pod -o wide`      | More info like node name, IP, etc. |
| `kubectl get pod -o yaml/json` | Shows full resource definition.    |
| `kubectl explain pod`          | Describes pod resource and fields. |

---

## 📂 **8. Namespace and Context Management**

| Command                           | Description                                |
| --------------------------------- | ------------------------------------------ |
| `kubectl get ns`                  | Lists all namespaces.                      |
| `kubectl create ns <name>`        | Creates a new namespace.                   |
| `kubectl delete ns <name>`        | Deletes a namespace and all its resources. |
| `kubectl get pods -n <namespace>` | Interacts with a specific namespace.       |

---

## 📋 **9. Copying Files**

| Command                         | Description                         |
| ------------------------------- | ----------------------------------- |
| `kubectl cp <src> <pod>:<dest>` | Copy files to a container.          |
| `kubectl cp <pod>:<src> <dest>` | Copy files from container to local. |

---

## 📊 **10. Metrics & Monitoring**

| Command             | Description                                                   |
| ------------------- | ------------------------------------------------------------- |
| `kubectl top pods`  | Shows CPU and memory usage of pods (requires Metrics Server). |
| `kubectl top nodes` | Shows usage stats of nodes.                                   |

---

## 🔒 **11. Access Control & Security**

| Command                                     | Description                                   |
| ------------------------------------------- | --------------------------------------------- |
| `kubectl auth can-i create pods`            | Checks if current user can perform an action. |
| `kubectl auth can-i get secrets --as user1` | Tests access for a different user.            |

---

## 🛠️ **12. Miscellaneous**

| Command                                         | Description                                    |
| ----------------------------------------------- | ---------------------------------------------- |
| `kubectl proxy`                                 | Starts a proxy to the API server on localhost. |
| `kubectl apply -k <dir>`                        | Applies a directory with `kustomization.yaml`. |
| `kubectl wait --for=condition=Ready pod/<name>` | Waits until the pod is ready.                  |
| `kubectl delete pod --grace-period=0 --force`   | Force delete a stuck pod.                      |

---

## 🔄 **13. Imperative Resource Creation Examples**

| Command                                              | Description                       |
| ---------------------------------------------------- | --------------------------------- |
| `kubectl run nginx --image=nginx`                    | Creates a deployment named nginx. |
| `kubectl expose pod nginx --port=80 --type=NodePort` | Exposes pod via service.          |

---

### 🧠 For Interview Tips:

- Understand difference between `apply` and `create`.
- Know `rollout`, `scale`, and `edit` for deployment changes.
- Be ready to `exec`, `logs`, `describe` for troubleshooting.
- Be familiar with `namespace`, `context`, and RBAC concepts.

---
