## Helm

Helm is a package manager for kubernetes and Helm Charts are its packages. They help, define, install and manage applications. A Helm Chart is a collection of files which describe the resources to be deploy an application or service in K8s. These files are written in YAML and are bundled together to form a deployable package.

## Helm Workflow

- **Create a Chart:** Use `helm create <chart-name>` to scaffold a new chart.<br>
- **Customize Values:** Modify `values.yaml` to include your application's configuration.<br>
- **Install the Chart:** Use `helm install <release-name> <chart-name>` to deploy the application to a Kubernetes cluster.<br>
- **Upgrade/Rollback:** Easily upgrade or roll back your deployments using `helm upgrade <release-name> <chart-name>` or `helm rollback <release-name> <revision number> `.<br>
- Whenever you perform the upgrade or rollback the revision count will keep on increasing.<br>

- **Uninstall:** Remove a release using `helm uninstall <release-name>`.<br>
- **List:** `helm list -a`.

- `helm install <release-name> --debug --dry-run <chart-name>` : The helm install command with --debug and --dry-run options simulates an installation process by rendering the templates and printing the output, but it also attempts to validate the generated manifests against the cluster's state. However, no resources are actually created or modified.

- `helm template <chart-name>`: The helm template command renders a Helm chart to its Kubernetes manifests without interacting with the Kubernetes API. It simply generates the manifests and outputs them to the terminal or a file.

- The `helm lint <chart-name>` command is a utility provided by Helm to validate and analyze a Helm chart for syntax and best practices issues. It runs a series of checks on the chart's structure and templates to ensure they adhere to Helm standards and avoid common mistakes.
