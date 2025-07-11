### 🚀 What is Argo CD?
Argo CD (Argo Continuous Delivery) is a GitOps tool for Kubernetes.

It automates deployments by continuously syncing your Kubernetes manifests (Helm, Kustomize, plain YAML, etc.) from a Git repository into your cluster.

So, instead of applying kubectl apply -f manually, Argo CD does that for you, automatically or on approval.

### 🧠 Core Concepts of Argo CD

**GitOps:**	Store all K8s manifests (infra & apps) in Git. Git is the "single source of truth."
Application	Custom K8s resource (kind: Application) that tells Argo CD what to deploy, from where, and where to.
**Sync:**	The process of making your cluster state match what's in Git.
**Drift Detection:**	Argo CD watches for changes outside Git and shows if your cluster has "drifted" from the desired state.
**Self-Healing:**	(If enabled) Argo CD automatically reverts manual changes by reapplying what’s in Git.

### 🧱 Argo CD Components (Services in AKS)
When you install Argo CD using kubectl, the following Pods (Deployments + Services) are created in the argocd namespace:

1. 🔌 argocd-server
This is the UI and API for Argo CD.

Exposes web dashboard (via HTTPS) and gRPC API (for CLI).

By default it is ClusterIP, but we can use:

kubectl port-forward for local access, or

LoadBalancer or Ingress for external access.

🔹 Accessed at:

localhost:8080 (when port-forwarded to 443)

External IP (if exposed as LoadBalancer)

2. 🧠 argocd-application-controller
This is the core brains of Argo CD.

Watches Application resources in the cluster.

Detects when Git and K8s diverge.

Triggers sync (automatically or manually).

Works with your Git repo to compare and apply manifests.

3. 📦 argocd-repo-server
Responsible for interacting with Git repos.

Fetches manifest files (YAML, Helm, Kustomize).

Renders/manages templates and makes them ready for sync.

Supports private Git with SSH, HTTPS, tokens, etc.

4. 🔒 argocd-dex-server (optional, if using SSO)
Provides Single Sign-On (SSO) via LDAP, GitHub, Google, Azure AD, etc.

Can be disabled if you’re using just basic auth.

5. 🧰 argocd-redis
Used as internal cache by Argo CD to speed up operations.