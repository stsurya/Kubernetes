## What does values.yaml file do in helm ?

The values.yaml file in a Helm chart contains the default configuration values for the chart. It is used to define variables that are referenced in the chart's templates, allowing you to customize the behavior of the deployment without modifying the actual templates.

When deploying a Helm chart, you can override the values in values.yaml by providing your own custom --set options or using a separate --values file.
