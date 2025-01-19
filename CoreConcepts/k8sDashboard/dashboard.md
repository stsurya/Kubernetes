## Kubernetes dashboard

To access the Kubernetes Dashboard for an AKS (Azure Kubernetes Service) cluster, you typically use the kubectl proxy command. Below is a detailed step-by-step guide to set up and access the dashboard:<br>

### Step 1: Enable Kubernetes Dashboard on AKS

Check if the Kubernetes Dashboard is already installed: Run the following command to check if the dashboard is deployed:<br>

`kubectl get svc -n kubernetes-dashboard`

If you see services related to the dashboard, it is already installed.<br>

If not installed, deploy the dashboard: Use the following command to deploy the Kubernetes Dashboard:<br>

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml`<br>
Replace v2.7.0 with the latest version if necessary.<br>

Verify the deployment: Check the dashboard pods and services:

```
kubectl get pods -n kubernetes-dashboard
kubectl get svc -n kubernetes-dashboard
```

Ensure the dashboard pod is running (STATUS: Running).<br>

### Step 2: Start the Proxy

Run kubectl proxy: Execute the following command to start a local proxy:<br>

`kubectl proxy`<br>
This command creates a local proxy to securely access the Kubernetes API server.<br>
By default, the proxy runs on `http://127.0.0.1:8001`.<br>
Access the Dashboard: Open your browser and go to the following URL:<br>

`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/` <br>
This will take you to the Kubernetes Dashboard login screen.<br>

### Step 3: Authentication for the Dashboard

To log in to the Kubernetes Dashboard, you need to authenticate using either a bearer token or a Kubeconfig file.
