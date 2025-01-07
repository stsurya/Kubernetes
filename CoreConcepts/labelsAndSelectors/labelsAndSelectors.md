## Labels and Selectors:

In Kubernetes, labels and selectors are used to group and manage resources effectively. They enable flexible and dynamic management of workloads by allowing you to identify and interact with specific objects in the cluster based on shared attributes.<br>

## Labels:

Labels are key-value pairs attached to Kubernetes objects (e.g., Pods, Nodes, Services, Deployments). They are used to organize and identify objects based on specific attributes, such as environment, application version, or region.<br>

```
apiVersion: v1
kind: Pod
metadata:
  name: my-app
  labels:
    app: web
    environment: production
    version: v1
spec:
  containers:
  - name: nginx
    image: nginx
```

## Selectors

Selectors are used to filter Kubernetes objects based on their labels. They allow you to specify criteria to select a group of resources with matching labels.<br>

Types of Selectors:

**Equality-based Selectors:**

- Match objects where the label key equals or does not equal a specific value.<br>
  **Examples:**<br>
  Match pods where app=web<br>
  `kubectl get pods -l app=web`<br>
  Exclude pods where environment=production<br>
  `kubectl get pods -l 'environment!=production'`<br>
  **Set-based Selectors:**<br>
- Match objects where the label key’s value is in (or not in) a set of values..<br>
  **Examples:**<br>
  Match pods where environment is production or staging<br>
  `kubectl get pods -l 'environment in (production, staging)'`<br>
  Exclude pods where version is v1 or v2<br>
  `kubectl get pods -l 'version notin (v1, v2)'`<br>
