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

### 3) What is values.yaml in Helm? How do you override it during deployment?

values.yaml in Helm stores default configuration values used in template rendering. It allows you to make your chart reusable and configurable. You can override it at deployment time using either a custom values file (-f) or inline key-value pairs using --set, giving you environment-specific control over how the application is deployed.

### 4) What is the difference between a Helm release and a chart?

> A **Helm chart** is a **package** that contains all the Kubernetes resource templates and configuration files needed to deploy an application. It defines *what* to deploy.

> A **Helm release** is a **running instance** of a chart that has been deployed to a Kubernetes cluster using specific configuration values. It represents *what has been deployed*.

**In simple terms:**

> The **chart** is like a blueprint or template, while the **release** is the actual deployed application created from that chart.

You can create **multiple releases** from the same chart, each with different names or configurations (e.g., dev, staging, prod).

### 5) Where are Helm releases stored?

> Helm releases are stored **inside the Kubernetes cluster** as **Secrets** (or optionally as ConfigMaps) in the same namespace where the release was installed.

By default:

* Helm stores release information in the **`Secret` objects** with the label:
  `owner=helm` and `status=deployed`.
* These secrets contain metadata such as the chart, values used, version, and revision history.

> This allows Helm to manage, upgrade, rollback, or uninstall releases by referring to the stored state in the cluster.

### 6) What's the use of version parameter in charts.yml ?

The version field in Chart.yaml defines the chart’s version and is critical for version control, upgrades, and repository management. It helps teams track changes to the chart’s structure and ensures the correct version is used during deployments.

### 7) What's release versioning in helm releases ?

Every time you install or upgrade a release, Helm increments the release revision number Stored in the cluster (as Secrets or ConfigMaps). Used for rollback, history tracking, and upgrade auditing.

### 8) What are helm hooks ?

Helm hooks are Kubernetes resources that run at specific stages of a release lifecycle, such as before or after installs, upgrades, or deletes. They’re defined using annotations and are useful for tasks like migrations, validations, or cleanups that need to run at precise moments during a deployment.

### 9) What happens when you do a helm uninstall?

When you run helm uninstall, all resources created by that release — such as Deployments, Services, PVCs, ConfigMaps, and Secrets — are removed. However, Persistent Volumes (PVs) are not deleted unless their reclaim policy is set to Delete. Helm only manages what it creates, so any manually created or shared resources are not affected.

### 10) What if the Helm upgrade fails midway? What will happen to the existing release?
If a Helm upgrade fails midway, the release is automatically marked as failed, and the previous release remains active and unchanged. Helm does not apply partial changes, ensuring the cluster stays in a consistent state. You can inspect the failure or manually roll back to a known good revision using helm rollback.

### 11) How would you migrate from kubectl apply to Helm for an exisitng application ?

To migrate from kubectl apply to Helm, you start by collecting all your existing YAML manifests, then create a Helm chart structure and move the manifests into the templates/ directory. You parameterize the values using Helm templating and test the chart locally. Once verified, you install it using helm install. This approach introduces better maintainability, reusability, and lifecycle management to your Kubernetes deployments.
