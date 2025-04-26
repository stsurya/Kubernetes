## NodeSelector

In Kubernetes, NodeSelector is a feature used to constrain which nodes a pod can be scheduled on. It helps you specify a simple mechanism to select nodes based on their labels. A NodeSelector is a field in the PodSpec that allows you to define a mapping of key-value pairs. The pod scheduler uses this mapping to find the nodes that satisfy the specified criteria.

**Example:**

```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
  - name: example-container
    image: nginx
  nodeSelector:
    disktype: ssd
    environment: production
```

### Explanation

Labels on Nodes: Nodes need to have the labels specified in the NodeSelector.<br>
For example:<br>

`kubectl label node <node-name> disktype=ssd environment=production`<br>

**Pod Spec:**<br>

- The nodeSelector section in the PodSpec defines the key-value pairs to match.<br>
- In this example, the pod will only schedule on nodes labeled with disktype=ssd and environment=production.<br>

**Key Points:**<br>

- NodeSelector is strict: If no nodes match the NodeSelector criteria, the pod will remain unscheduled.<br>
- Simple match: NodeSelector supports only exact matches (key=value). For advanced scheduling, you would use node affinity.<br>

### When to Use NodeSelector ?

When you need to:<br>

- Ensure specific workloads run on nodes with specific hardware (e.g., GPUs, SSDs).<br>
- Assign workloads to specific environments (e.g., staging, production).<br>
- Separate workloads across different nodes for isolation or resource allocation purposes.<br>

**Limitations:**

- No complex matching: For more expressive constraints (e.g., "one of these values" or "not this value"), use Node Affinity.<br>

### Differene between nodeSelector and nodeAffinity

| Feature             | `nodeSelector`                                                                                   | `nodeAffinity`                                                                                                                                                                                                              |
| :------------------ | :----------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Definition**      | Basic way to tell Kubernetes _"run this pod on a node with this label."_                         | Advanced, flexible way to tell Kubernetes _"prefer" or _"require"\* pods to run on nodes based on rules.                                                                                                                    |
| **Syntax**          | Very simple. Just one key-value pair.                                                            | More powerful. Can specify multiple conditions, operators like `In`, `NotIn`, `Exists`, etc.                                                                                                                                |
| **Type of Binding** | Hard rule. Pod **must** be scheduled to a node matching the label.                               | Can have **required rules** (must match) or **preferred rules** (better if matches, but can still run elsewhere).                                                                                                           |
| **Use Cases**       | When you know exactly which nodes should run a pod (example: all GPU nodes labeled `gpu: true`). | When you want more flexibility, like: "Prefer nodes with SSDs, but if not available, still schedule elsewhere."                                                                                                             |
| **Example**         | `yaml nodeSelector:   disktype: ssd `                                                            | `yaml affinity:   nodeAffinity:     requiredDuringSchedulingIgnoredDuringExecution:       nodeSelectorTerms:       - matchExpressions:         - key: disktype           operator: In           values:             - ssd ` |
| **Complexity**      | Very simple.                                                                                     | Slightly complex but **very powerful**.                                                                                                                                                                                     |

---

**Summary:**

- 👉 `nodeSelector` = simple matching (`key: value`)
- 👉 `nodeAffinity` = smarter matching (multiple keys, rules, preferred/required conditions)
