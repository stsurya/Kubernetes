## NodeAffinity

Node Affinity in Kubernetes is an advanced feature used to control the scheduling of pods onto nodes. It allows you to set rules (soft or hard constraints) based on node labels, enabling more expressive and flexible scheduling compared to NodeSelector.

### Key Features of Node Affinity

- **Advanced Matching:** Supports operators like In, NotIn, Exists, etc.<br>
- **Soft and Hard Constraints:**<br>

  - RequiredDuringSchedulingIgnoredDuringExecution: Pods are scheduled on nodes that match the rules. This is a hard constraint.<br>
  - PreferredDuringSchedulingIgnoredDuringExecution: Kubernetes tries to schedule pods on nodes that match the rules, but it's a soft preference.<br>
