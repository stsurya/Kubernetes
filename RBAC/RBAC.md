## RBAC

RBAC (Role-Based Access Control) in Kubernetes (k8s) is a security mechanism that controls user and service account access to resources based on roles and permissions. Here's a breakdown:

Key Components:

1. Roles: Define a set of permissions (e.g., create, read, update, delete) for a specific resource (e.g., pods, services, deployments).
2. RoleBindings: Bind a role to a user, group, or service account, granting them the permissions defined in the role.
3. ClusterRoles: Similar to roles, but apply cluster-wide.
4. ClusterRoleBindings: Bind a cluster role to a user, group, or service account, granting them cluster-wide permissions.

A Role always sets permissions within a particular namespace; when you create a Role, you have to specify the namespace it belongs in.

ClusterRole, by contrast, is a non-namespaced resource. The resources have different names (Role and ClusterRole) because a Kubernetes object always has to be either namespaced or not namespaced; it can't be both.

ClusterRoles have several uses. You can use a ClusterRole to:

define permissions on namespaced resources and be granted access within individual namespace(s)
define permissions on namespaced resources and be granted access across all namespaces
define permissions on cluster-scoped resources
