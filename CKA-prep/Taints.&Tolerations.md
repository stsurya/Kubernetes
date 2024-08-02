kubectl taints nodes node01 spray=mortein:NoSchedule

Three effect:

**No Schedule:** This prevents the new pods from being scheduled on, but remains the exisitng pods on Node.
**PreferNoSchedule:** This discourages scheduling new pods, but allows if it is necessary.
**NoExecute:** removes existing pods without a toleration and prevents new ones from being scheduled.
