## Taints and Tolerations

Taint and tolerations work together to ensure that pods are shceduled on appropriate nodes. If one or more taints are applied on a node; this marks that the node should not accept any pods that do not tolerate the taints.
Three effect:

**No Schedule:** This prevents the new pods from being scheduled on, but remains the exisitng pods on Node.<br>
**PreferNoSchedule:** This discourages scheduling new pods, but allows if it is necessary.<br>
**NoExecute:** removes existing pods without a toleration and prevents new ones from being scheduled.<br>

`kubectl taints nodes node01 spray=mortein:NoSchedule`
