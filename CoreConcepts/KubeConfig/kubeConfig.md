## KubeConfig

- In Kubernetes, the kubeconfig file is a configuration file that stores information about how to connect to kubernetes clusters, it is essential for managing access to kubernetes clusters and provides the necessary details for kubectl to communicate with clsuter.<br>

Key Components of kubernetes cluster:<br>

### 1. Clusters:

- Defines the Kubernetes API server addresses (URLs) and connection settings.
- Includes the server field, which points to the cluster's API server endpoint.
- May include additional settings like certificate-authority for validating server certificates.

### 2. Users:

- Specifies the authentication methods for accessing the clsuters.
- Authentication includes certifications, tokens and other mechanisms.

### 3. Contexts:

- Represents a combination of a cluster, a user, and a namespace.
- A context specifies the cluster to interact with, the user credentials to use, and the namespace for commands.

### 4. Current Context:

- Specifies the default context to use when executing kubectl commands.
- You can override the current context by specifying the --context flag in kubectl commands.<br>
  `current-context: my-context`

**Example:**<br>

```
apiVersion: v1
kind: Config
clusters:
- name: my-cluster
  cluster:
    server: https://my-cluster.example.com
    certificate-authority: /path/to/ca.crt
users:
- name: my-user
  user:
    client-certificate: /path/to/client.crt
    client-key: /path/to/client.key
contexts:
- name: my-context
  context:
    cluster: my-cluster
    user: my-user
    namespace: default
current-context: my-context

```

**Default Location:** The default location for the kubeconfig file is ~/.kube/config on Unix-based systems and %USERPROFILE%\.kube\config on Windows. You can specify a different file using the --kubeconfig flag or by setting the KUBECONFIG environment variable.
