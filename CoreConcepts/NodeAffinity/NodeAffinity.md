## NodeAffinity

Node Affinity in Kubernetes is an advanced feature used to control the scheduling of pods onto nodes. It allows you to set rules (soft or hard constraints) based on node labels, enabling more expressive and flexible scheduling compared to NodeSelector.

### Key Features of Node Affinity

- **Advanced Matching:** Supports operators like In, NotIn, Exists, etc.<br>
- **Soft and Hard Constraints:**<br>

  - **RequiredDuringSchedulingIgnoredDuringExecution:** Pods are scheduled on nodes that match the rules. This is a hard constraint.<br>
  - **PreferredDuringSchedulingIgnoredDuringExecution:** Kubernetes tries to schedule pods on nodes that match the rules, but it's a soft preference.<br>

**Example:**

Applying labels on node.<br>

`kubectl label node <node-name> disktype=ssd environment=production`

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd
          - key: environment
            operator: In
            values:
            - production
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: zone
            operator: In
            values:
            - us-east-1a
  containers:
  - name: example-container
    image: nginx
```

### Explanation:

- **requiredDuringSchedulingIgnoredDuringExecution:** The pod must be scheduled on nodes that match the rules.<br>
  In the example above:<br>

  - The node must have the label disktype=ssd.<br>
  - The node must have the label environment=production.<br>

- **preferredDuringSchedulingIgnoredDuringExecution:** Kubernetes prefers nodes that match the rules but does not enforce them.<br>
  In the example above:<br>
  - The scheduler tries to place the pod on a node with the label zone=us-east-1a.<br>

### Operators in Node Affinity

Operator Description<br>
In = Matches if the label's value is in the specified list.<br>
NotIn = Matches if the label's value is not in the specified list.<br>
Exists = Matches if the label key exists on the node.<br>
DoesNotExist = Matches if the label key does not exist on the node.<br>
Gt = Matches if the label's value is greater than the specified value.<br>
Lt = Matches if the label's value is less than the specified value.<br>

---

# 🧠 Kubernetes Pod Scheduling - Quick Summary

---

## 1️⃣ Node Selector (Simple Scheduling)

- Direct way to schedule a Pod on nodes with specific labels.
- Example:

```
nodeSelector:
  disktype: ssd
```

✅ Pod will schedule only on nodes with `disktype=ssd`.

---

## 2️⃣ Node Affinity (Advanced Scheduling)

- **More powerful and flexible** than `nodeSelector`.
- Two main types:

| Type                                              | Meaning                                                     |
| :------------------------------------------------ | :---------------------------------------------------------- |
| `requiredDuringSchedulingIgnoredDuringExecution`  | **Hard rule** - Pod must meet these conditions to schedule. |
| `preferredDuringSchedulingIgnoredDuringExecution` | **Soft rule** - Pod tries to meet, but not mandatory.       |

---

## 3️⃣ `matchExpressions`

- More complex matching.
- Format:
  - `key`: label key
  - `operator`: In, NotIn, Exists, DoesNotExist
  - `values`: possible label values

---

## 4️⃣ **AND** and **OR** in Affinity

| Condition                                  | Behavior                                       |
| :----------------------------------------- | :--------------------------------------------- |
| Multiple `matchExpressions`                | **AND** between them — all must match          |
| Multiple `values` inside `matchExpression` | **OR** between them — any one value must match |

✅ Example (AND):

```
matchExpressions:
  - key: disktype
    operator: In
    values: [ssd]
  - key: storage
    operator: In
    values: [hdd]
```

✅ Example (OR):

```
matchExpressions:
  - key: disktype
    operator: In
    values: [ssd, nvme]
```

---

## 5️⃣ PodAffinity / PodAntiAffinity (Pod-to-Pod Scheduling)

- **PodAffinity**: Schedule close to other pods (example: apps that talk to each other).
- **PodAntiAffinity**: Spread pods across nodes (example: replicas on different nodes).

✅ Example for PodAntiAffinity (preferred):

```
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
              - key: replicaset
                operator: In
                values:
                  - rs0.main
          topologyKey: kubernetes.io/hostname
```

---

## 6️⃣ Bonus - Labeling nodes with multiple labels

- Example:

```
kubectl label nodes <node-name> disktype=ssd storage=hdd
```

✅ You can add multiple labels at once.

---

# ✨ Final Pro Tip

👉 Use `kubectl get nodes --show-labels` to verify node labels.  
👉 Remember: `requiredDuringSchedulingIgnoredDuringExecution` = **mandatory**,  
`preferredDuringSchedulingIgnoredDuringExecution` = **best effort**.

Awesome question again! 🔥 Let’s break **weight** down very **easily**:

---

# 🎯 What is `weight` in Affinity?

✅ `weight` is **used only with** `preferredDuringSchedulingIgnoredDuringExecution` (not with required).  
✅ It tells Kubernetes:  
**"How important is this preference for me?"**

👉 The **higher** the weight (closer to 100), the **more Kubernetes tries** to satisfy it.

---

# 🎯 How does it work?

When Kubernetes has to choose between multiple nodes:

- It **scores** each node based on matching your preferred rules.
- Nodes matching **higher-weight** preferences get **higher scores**.
- The node with the **best score wins** and pod is scheduled there!

---

# ✍️ Simple example:

```
affinity:
  podAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
              - key: app
                operator: In
                values:
                  - frontend
          topologyKey: kubernetes.io/hostname
```

**Meaning:**  
➔ "Try to schedule this pod close to `frontend` pods with very high preference (weight=100)."

But if not possible, **it’s okay**, just best-effort.

---

# 📈 How is the score calculated?

- Each preferred rule you define contributes to the **total score**.
- Weight decides **how much contribution** each rule makes.
- **Final scheduling** is based on total weighted score!

👉 **Higher weight = stronger pull** to satisfy that preference.

---

# 📦 Important:

- `weight` can be **1 to 100** (nothing beyond 100).
- If you have **multiple preferred rules**, each rule’s weight matters.
- Kubernetes **adds up** all weighted scores when choosing a node.

---

# 🧹 Very simple way to remember:

| Weight | Meaning                               |
| :----- | :------------------------------------ |
| 100    | Try **very hard** to follow this rule |
| 50     | Try **medium effort**                 |
| 10     | Just a **small preference**           |
| 1      | Very **low importance**               |

---

# 🚀 Conclusion:

| Term                                              | Meaning                             |
| :------------------------------------------------ | :---------------------------------- |
| `requiredDuringSchedulingIgnoredDuringExecution`  | Strict rule (no weight needed)      |
| `preferredDuringSchedulingIgnoredDuringExecution` | Soft rule (weight shows importance) |
