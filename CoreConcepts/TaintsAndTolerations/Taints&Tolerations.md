## Taints and Tolerations

Taint and tolerations work together to ensure that pods are shceduled on appropriate nodes. If one or more taints are applied on a node; this marks that the node should not accept any pods that do not tolerate the taints.
Three effect:

**No Schedule:** This prevents the new pods from being scheduled on, but remains the exisitng pods on Node.<br>
**PreferNoSchedule:** This discourages scheduling new pods, but allows if it is necessary.<br>
**NoExecute:** removes existing pods without a toleration and prevents new ones from being scheduled.<br>

`kubectl taint nodes node01 spray=mortein:NoSchedule`

The above commadn will taint a node to not to scheudule any more new pods on node01.<br>
**Tolerations yaml:**

```
apiVersion: v1
kind: Pod
metadata:
  name: bee
spec:
  containers:
  - name: nginx
    image: nginx
  tolerations:
  - key: "spray"
    operator: "Equal"
    value: "mortein"
    effect: "NoSchedule"
```

The above yaml file will create a pod bee and schedule it on node01 as it can tolerate the node01.<br>

- We cannot set toleratiosn via kubectl commands, we need to use YAML only.
- Always controlplane node is tainted to NoSchedule.

**Remove the taint for exisintg node**
`kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-`
