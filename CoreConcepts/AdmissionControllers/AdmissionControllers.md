### 📌 **Admission Controllers in Kubernetes – Interview-Ready Notes**

---

### 🔷 **What are Admission Controllers in Kubernetes?**

Admission Controllers are **plug-ins** that **intercept requests to the Kubernetes API server** _after authentication and authorization_, but _before_ the object is persisted to etcd.

They help enforce **policies** on how your cluster should behave, like:

- Security rules
- Resource limits
- Namespace restrictions
- Label enforcement

---

### 🔄 **Request Flow with Admission Controllers:**

1. **User makes request to API Server**
2. **Authentication**
3. **Authorization**
4. **Admission Controllers (Mutating → Validating)**
5. **etcd (Persistence)**

---

### 🔧 **Types of Admission Controllers**

1. **Mutating Admission Controllers**

   - **Modify** the object before it is stored.
   - E.g., inject sidecars (like in Istio), set default labels, etc.

2. **Validating Admission Controllers**

   - **Validate** the object _after_ all mutations are done.
   - Reject the request if it doesn't meet your rules.

> **Note**: Both can be used together. Mutating is executed **before** validating.

---

### 📋 **Examples of Built-in Admission Controllers**

| Controller Name         | Description                                                                        |
| ----------------------- | ---------------------------------------------------------------------------------- |
| `NamespaceLifecycle`    | Ensures namespace rules (e.g., objects can't be created in terminating namespaces) |
| `LimitRanger`           | Enforces `limits` on CPU/Memory in a namespace                                     |
| `ServiceAccount`        | Automatically assigns service accounts to pods                                     |
| `NodeRestriction`       | Prevents kubelets from modifying other nodes                                       |
| `PodSecurity`           | Enforces Pod Security Standards (`restricted`, `baseline`, `privileged`)           |
| `ResourceQuota`         | Enforces quota limits per namespace                                                |
| `DefaultStorageClass`   | Automatically assigns default storage class to PVCs                                |
| `TaintNodesByCondition` | Adds taints to nodes for certain conditions                                        |

---

### 🛠️ **Custom Admission Controllers**

- You can write your own using:

  - **Webhook Admission Controllers**

    - Kubernetes will **send a REST API call** to your custom service.
    - Can be:

      - `MutatingAdmissionWebhook`
      - `ValidatingAdmissionWebhook`

---

### 📦 **Popular Tools That Use Admission Controllers**

| Tool               | Use Case                                                   |
| ------------------ | ---------------------------------------------------------- |
| **OPA Gatekeeper** | Policy-as-code (Validating webhooks)                       |
| **Kyverno**        | Native Kubernetes policy engine (both mutate and validate) |
| **Istio**          | Injects Envoy sidecars into pods (Mutating webhook)        |

---

### 📌 **Example: How Kyverno Works as an Admission Controller**

- You define a policy like “All pods must have resource limits.”
- Kyverno’s webhook intercepts pod creation.
- If resource limits are missing, it can:

  - **Mutate**: Add them automatically.
  - **Validate**: Reject the pod.

---

### ❓**Interview Tip: Key Questions**

- Q: What happens if a Validating webhook is down?

  - A: It depends on the `failurePolicy`. If `Ignore`, the request proceeds; if `Fail`, the request is rejected.

- Q: Can admission controllers run on managed services like AKS/EKS?

  - A: You can use **webhooks**, but can't modify built-in ones. Kyverno or OPA Gatekeeper are commonly used.
