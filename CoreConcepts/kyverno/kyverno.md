## Kyverno

---

## ✅ What is Kyverno?

**Kyverno** is a **Kubernetes-native policy engine** that allows you to **validate**, **mutate**, and **generate** Kubernetes resources using **declarative policies**.

- Created by **Nirmata**, now a CNCF project.
- Does not require learning a new language like OPA’s Rego (used in Gatekeeper).
- Integrates with Kubernetes admission controllers and works with `kubectl`, `kubectl apply`, and CI/CD.

---

## 🔍 Why Kyverno?

- **Native to Kubernetes** – uses , no new language.
- **No external tooling needed** – runs as a K8s admission controller.
- **Simple learning curve** – easier than Rego/Gatekeeper.
- **Policy as code** – version control your security and governance rules.

---

## 🔧 Kyverno Use Cases

1. **Validation Policies**

   - Enforce best practices or security rules.
   - Example: Ensure all Pods have resource requests/limits.

2. **Mutation Policies**

   - Automatically modify incoming resources.
   - Example: Add default labels, annotations, or tolerations.

3. **Generation Policies**

   - Automatically generate resources.
   - Example: Create a default NetworkPolicy when a new namespace is created.

4. **Background Scanning**

   - Continuously validate existing resources (not just new ones).

---

## 📌 Kyverno vs OPA Gatekeeper

| Feature              | Kyverno | OPA Gatekeeper |
| -------------------- | ------- | -------------- |
| Language             |         | Rego           |
| Learning Curve       | Easier  | Steep          |
| Mutation             | Yes     | No             |
| Generation           | Yes     | No             |
| Background Scan      | Yes     | Yes            |
| Native to Kubernetes | Yes     | No             |

---

## 🧩 Kyverno Policy Structure

Each Kyverno policy has:

```
apiVersion: kyverno.io/v1
kind: ClusterPolicy or Policy
metadata:
  name: require-labels
spec:
  rules:
    - name: check-required-labels
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "app label is required"
        pattern:
          metadata:
            labels:
              app: "?*"
```

---

## ✏️ Kyverno Commands

- `kubectl apply -f policy.` – Apply a Kyverno policy.
- `kyverno apply policy. --resource resource.` – Test a policy offline.
- `kubectl get cpol` – List ClusterPolicies.
- `kyverno generate report` – Create reports on policy violations.

---

## 🛡️ Admission Controller & Kyverno

- Kyverno runs as a **mutating** and **validating admission controller**.
- It intercepts requests **before they’re persisted** to etcd and enforces policy decisions.

---

## 🔄 Kyverno with CI/CD

- Integrate Kyverno in **GitOps pipelines** to enforce policies before deployment.
- Use `kyverno-cli` in pipelines to run offline policy validation.

---

## 🌐 Kyverno Policies Examples

### 1. Validate all Pods have resource limits

```
validate:
  message: "CPU and memory limits are required"
  pattern:
    spec:
      containers:
        - resources:
            limits:
              memory: "?*"
              cpu: "?*"
```

### 2. Mutate Pod to add a label

```
mutate:
  patchStrategicMerge:
    metadata:
      labels:
        env: "dev"
```

### 3. Generate a default NetworkPolicy for every new namespace

```
generate:
  kind: NetworkPolicy
  name: default-deny
  namespace: "{{request.object.metadata.name}}"
  data:
    spec:
      podSelector: {}
      policyTypes:
        - Ingress
```

---

## 🧠 Kyverno Interview Questions

**1. What is Kyverno and how is it used in Kubernetes?**
Kyverno is a Kubernetes-native policy engine used to enforce policies for validation, mutation, and generation of resources using -based configuration.

**2. How is Kyverno different from OPA Gatekeeper?**
Kyverno uses (no need to learn Rego), supports mutation and generation of resources, and is easier to use natively in Kubernetes.

**3. Can you give an example of a Kyverno policy?**
Yes. A policy that enforces `app` label on all Pods can be written using a `validate` rule to match Pods and check for the label.

**4. How does Kyverno enforce policies?**
It acts as a Kubernetes admission controller and intercepts requests before they are persisted to the Kubernetes API server.

**5. How do you integrate Kyverno in a CI/CD pipeline?**
Use the `kyverno apply` or `kyverno-cli` tool in your pipeline to test resources against policies before applying them to a cluster.

---

## ❓ Scenario

> **A Pod is already running in the cluster. Later, you apply a Kyverno `ClusterPolicy` that would have prevented that Pod from being created. Will Kyverno validate or act on the existing Pod now?**

---

## ✅ Short Answer:

> **No, Kyverno will NOT validate or mutate existing resources by default** when a policy is applied.
> It **only intercepts new `create` or `update` requests** via the admission controller.

So, the existing Pod will **continue running unaffected** even if it violates the newly applied policy.

---

## 🧠 Deeper Insight:

### ✋ Kyverno Admission Controller Mode

- Kyverno’s admission controller **only handles create/update/delete** requests.
- It does **not retroactively apply policies** to existing resources unless you enable background validation.

---

## 🌀 How to Enforce Policies on Existing Resources?

You need to enable **Kyverno Background Scanning** using:

```
spec:
  validationFailureAction: enforce
  background: true
```

### ✅ Example:

```
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: check-app-label
spec:
  validationFailureAction: enforce
  background: true
  rules:
    - name: require-app-label
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "app label is required"
        pattern:
          metadata:
            labels:
              app: "?*"
```

This will make Kyverno **scan existing resources in the background** and report violations (like existing Pods without the `app` label).

---

## 🔍 How to See Violations?

Use the **Policy Reports** generated by Kyverno:

```
kubectl get policyreport,clusterpolicyreport
```

You’ll see violations like:

```
NAME                 RESULTS  RESOURCES
policyreport-pod123    1      pod123
```

---

## ❌ But Important Note:

Even with `background: true`, Kyverno **won’t delete or patch the existing Pod** that violates the policy.
It just reports the violation.

---

## 🛠️ So How Do You Fix Existing Violations?

You can:

- Manually fix the resource (e.g., add labels to Pods).
- Use a **mutate policy + background scan** + a controller that re-applies Pods.
- Or **recreate** the resource — the new `create` will be blocked if the policy fails.

---

## ✅ Summary

| Scenario                          | Will Kyverno Act?                   |
| --------------------------------- | ----------------------------------- |
| Existing Pod before policy        | ❌ No                               |
| New Pod after policy              | ✅ Yes (Admission controller)       |
| Existing Pod + `background: true` | ✅ Reports violation, doesn't block |
| Existing Pod + mutate             | ⚠️ Only works on new create/update  |

---
