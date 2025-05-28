## 🌊 **What is Velero?**

**Velero** is an open-source tool that provides:

- **Backup** of Kubernetes cluster resources and persistent volumes
- **Restore** from backups in case of disaster or accidental deletion
- **Migration** of cluster resources and volumes to other clusters

It supports **cloud providers** like AWS, Azure, GCP, and supports plugins for more flexibility.

---

## 🧠 **How Velero Works**

Velero operates in two parts:

### 1. **Server-side (Velero Deployment in Cluster)**

This is a Kubernetes deployment (`velero` namespace) that runs controllers watching for `Backup`, `Restore`, and `Schedule` custom resources.

### 2. **CLI Client (`velero` binary)**

Used to interact with the Velero server to create backups, restores, view status, etc.

---

## 🧱 **Velero Architecture**

```
+--------------------+      +------------------+
|    velero CLI      | ---> |  velero pod      | --> talks to Kubernetes API
+--------------------+      | (runs in cluster)|
                            +--------+---------+
                                     |
                                     v
                           +--------------------+
                           |   Object Storage   | (S3, Azure Blob, GCS)
                           +--------------------+
```

- Stores backups as **.tar.gz** files in cloud object storage.
- Backs up **Kubernetes resources** and optionally **persistent volume data** (via Restic or CSI plugins).

---

## 🧪 **Velero Features**

| Feature         | Description                              |
| --------------- | ---------------------------------------- |
| Backup          | Cluster resources and PV snapshots       |
| Restore         | Recover from backup                      |
| Schedule        | Automated backups using cron             |
| Hooks           | Run commands before/after backup/restore |
| Volume Snapshot | Uses cloud-native snapshots or Restic    |
| Migration       | Move apps between clusters               |

---

## ☁️ **Velero on Azure Example**

### 🔧 Prerequisites

- Azure Storage Account + Blob Container
- Kubernetes cluster (e.g., AKS)
- Azure CLI
- Velero CLI

---

## 🚀 **Velero Installation (Azure Example)**

### Step 1: Create Azure Resources

```bash
# Create a resource group
az group create --name velero-rg --location eastus

# Create a storage account
az storage account create \
    --name velerobackupsa \
    --resource-group velero-rg \
    --sku Standard_GRS \
    --encryption-services blob

# Get storage key
AZURE_STORAGE_KEY=$(az storage account keys list \
  --resource-group velero-rg \
  --account-name velerobackupsa \
  --query '[0].value' -o tsv)

# Create a blob container
az storage container create \
  --name velero \
  --account-name velerobackupsa \
  --public-access off
```

### Step 2: Create Credentials File (credentials-velero)

```ini
[default]
accountName = velerobackupsa
accountKey = <paste-your-key-here>
```

### Step 3: Install Velero

```bash
velero install \
    --provider azure \
    --plugins velero/velero-plugin-for-microsoft-azure:v1.8.0 \
    --bucket velero \
    --secret-file ./credentials-velero \
    --backup-location-config resourceGroup=velero-rg,storageAccount=velerobackupsa \
    --use-restic \
    --snapshot-location-config apiTimeout=5m
```

---

## 🔙 **Backup Commands**

### Backup the whole cluster

```bash
velero backup create cluster-backup-01
```

### Backup a specific namespace

```bash
velero backup create ns-backup --include-namespaces dev
```

### View backups

```bash
velero backup get
```

---

## 🔁 **Restore Commands**

### Restore from a backup

```bash
velero restore create --from-backup ns-backup
```

### View restores

```bash
velero restore get
```

---

## ⏰ **Schedule Backups**

```bash
velero schedule create daily-backup \
  --schedule "0 1 * * *" \
  --include-namespaces dev
```

> This creates a daily backup at 1:00 AM for the `dev` namespace.

---

## 🔐 **Restic for Volume Backup**

Velero uses **Restic** to backup Persistent Volumes (PVCs) if CSI or snapshot plugins are not available.

To annotate PVCs for backup:

```bash
kubectl annotate pod <pod-name> backup.velero.io/backup-volumes=<volume-name>
```

---

## 📂 **Check Backup Content**

```bash
velero backup describe cluster-backup-01 --details
```

---

## 🧹 **Delete Backups**

```bash
velero backup delete cluster-backup-01
```

---

## 🧪 **Test Backup/Restore in Practice**

1. Deploy a test app with Persistent Volume.
2. Take backup: `velero backup create test-app-backup`
3. Delete app and PVCs.
4. Restore: `velero restore create --from-backup test-app-backup`
5. Verify application comes back.

---

## 🛠️ **Velero Troubleshooting Tips**

| Issue                    | Fix                                                         |
| ------------------------ | ----------------------------------------------------------- |
| No volume data backed up | Ensure `--use-restic` used during install and PVC annotated |
| Backup stuck             | Check Velero pod logs                                       |
| Restore failed           | Check CRDs, service account roles                           |
| Credentials issue        | Ensure correct `credentials-velero` and permissions         |

---

## 📚 **Useful Commands Reference**

| Task               | Command                                             |
| ------------------ | --------------------------------------------------- |
| Install Velero     | `velero install ...`                                |
| Backup all         | `velero backup create <name>`                       |
| Backup specific NS | `velero backup create --include-namespaces <ns>`    |
| View backups       | `velero backup get`                                 |
| View details       | `velero backup describe <name> --details`           |
| Restore            | `velero restore create --from-backup <backup-name>` |
| Schedule           | `velero schedule create ...`                        |
| Delete backup      | `velero backup delete <name>`                       |
| Logs               | `kubectl logs deployment/velero -n velero`          |

---

## ✅ Best Practices

- Schedule regular backups (daily/nightly)
- Use Restic for PV backups in dev/test clusters
- Verify restores regularly
- Store credentials securely
- Tag resources properly for traceability
