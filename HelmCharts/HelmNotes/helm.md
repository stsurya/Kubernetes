## Helm

Helm is a package manager for kubernetes and Helm Charts are its packages. They help, define, install and manage applications. A Helm Chart is a collection of files which describe the resources to be deploy an application or service in K8s. These files are written in YAML and are bundled together to form a deployable package.

## Helm Workflow

**Create a Chart:** Use helm create `<chart-name>` to scaffold a new chart.<br>
**Customize Values:** Modify values.yaml to include your application's configuration.<br>
**Install the Chart:** Use helm install `<release-name> <chart-name>` to deploy the application to a Kubernetes cluster.<br>
**Upgrade/Rollback:** Easily upgrade or roll back your deployments using helm upgrade or helm rollback.<br>
**Uninstall:** Remove a release using helm uninstall `<release-name>`.<br>
