## What does charts.yml file contain in YAML ?

- This file conntains the metadata about the chart itself.
- It helps to understand what the chart is for, its version, dependencies, and other descriptive information.

The key components of charts.yaml file: <br>

**1. apiVersion:** Specifies the API version of the Helm chart.<br>
v1: Used for Helm 2.<br>
v2: Used for Helm 3 (recommended for modern charts).<br>

**2. name:** The name of the chart. This should be a unique identifier for your chart.<br>

**3. description:** A brief description of what the chart does or its purpose.<br>

**4. type (Optional):** Defines the type of chart. Defaults to application if omitted.<br>
**Common Values:**<br>
application: Used for deploying applications.<br>
library: Used for reusable charts (e.g., for shared templates).<br>

**5. version:** The version of the Helm chart itself.<br>

**6. appVersion:** The version of the application that this chart deploys. This is for informational purposes and does not affect the chart's functionality.

## What does charts/ folder do in helm ?

The `charts/` folder in a Helm chart is used to manage dependencies for your Helm chart. It contains other Helm charts that your chart depends on, essentially functioning as a place to include child charts in a parent chart.
