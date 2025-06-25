## Helm Iqs

### 1. What is Helm and what are Helm charts? Why is Helm used in Kubernetes deployments?

A) Helm is a Kubernetes package manager that helps define, install, and manage applications using Helm Charts — which are reusable templates of Kubernetes manifests. It streamlines deployments, promotes reuse, enables environment-specific customization, and supports versioning and rollback, making it essential for managing complex Kubernetes applications at scale.<br>

### 2. What are the components of a Helm chart?

A) > A Helm chart is a package that defines a Kubernetes application. It consists of several key components:

1. **`Chart.yaml`** – Contains metadata like the chart’s name, version, app version, and description.
2. **`values.yaml`** – Holds default configuration values that are injected into the templates, making the chart customizable for different environments.
3. **`templates/`** – A folder of Kubernetes manifest templates (like Deployment, Service, ConfigMap) written using Go templating. These are rendered using values from `values.yaml`.
4. **`charts/`** *(optional)* – Holds subcharts or chart dependencies, useful when your application depends on other services like databases.
5. **`NOTES.txt`** *(optional)* – Displays helpful post-installation or upgrade messages to the user.
6. **`README.md` and `LICENSE`** *(optional)* – Provide documentation and licensing information.

> These components together make Helm charts reusable, configurable, and ideal for managing complex Kubernetes deployments efficiently.