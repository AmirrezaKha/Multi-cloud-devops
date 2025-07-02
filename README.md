# Multi-Cloud Data Lake & Warehouse Project

This project implements a data lake and data warehouse platform using Azure and AWS infrastructure, orchestrated by Terraform, containerized with Docker, and managed with Airflow, Spark, Trino, and Atlas.

---

## Project Components

- **Terraform**: Infrastructure as Code to provision VPCs, Kubernetes clusters (AKS/EKS), networking, and services.
- **Docker**: Container images for Airflow, Spark & Trino, and Atlas services.
- **Helm**: Kubernetes package manager used to deploy services on AKS/EKS clusters.
- **Airflow**: Workflow orchestration tool running DAGs to move data between data lakes and warehouses on Azure and AWS.
- **DAGs**: Airflow Directed Acyclic Graphs automating data ingestion, transformation, and loading.

---

## Prerequisites

- Install [Terraform](https://www.terraform.io/downloads.html) (v1.5.7+ recommended)
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Install [Helm](https://helm.sh/docs/intro/install/)
- Install Azure CLI (`az`) and AWS CLI (`aws`), configured with your credentials
- Access to Azure DevOps or AWS CodePipeline (optional for CI/CD automation)

---

## Setup & Deployment Instructions

### 1. Clone the repository

```bash
git clone https://your-repo-url.git
cd your-repo
```

### 2. Build and push Docker images

Build images locally or through CI/CD pipelines and push to your container registries:

```bash
docker build -t youracr.azurecr.io/airflow:latest docker/airflow
docker push youracr.azurecr.io/airflow:latest

docker build -t youracr.azurecr.io/spark-trino:latest docker/spark_trino
docker push youracr.azurecr.io/spark-trino:latest

docker build -t youracr.azurecr.io/atlas:latest docker/atlas
docker push youracr.azurecr.io/atlas:latest
```

*Replace `youracr.azurecr.io` with your Azure Container Registry address. For AWS, replace with your ECR repository URI.*

---

### 3. Provision infrastructure with Terraform

Navigate to the Terraform directory and initialize:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

This will create all required cloud infrastructure components on Azure and AWS.

---

### 4. Deploy services on Kubernetes

Get your Kubernetes cluster credentials:

**Azure:**

```bash
az aks get-credentials --resource-group your-aks-rg --name your-aks-cluster
```

**AWS:**

```bash
aws eks update-kubeconfig --region your-region --name your-eks-cluster
```

Then install or upgrade your Helm charts:

```bash
helm upgrade --install spark-trino ./modules/spark_trino/helm_chart --namespace default
helm upgrade --install atlas ./modules/atlas/helm_chart --namespace default
helm upgrade --install airflow ./modules/airflow/helm_chart --namespace default
```

---

### 5. Deploy Airflow DAGs

Copy DAG files to Airflow DAGs folder (if mounted via PVC):

```bash
cp dags/*.py /path/to/airflow/dags/
```

Or push DAG changes to your DAGs repo and redeploy Airflow pods if using Git sync.

---

## Usage

- Access Airflow Web UI at `http://<airflow-service-ip>:8080` to trigger and monitor DAG runs.
- Use Spark and Trino clusters for data processing and querying.
- Use Atlas UI for data governance and metadata management.

---

## Troubleshooting

- Check Kubernetes pods status:

  ```bash
  kubectl get pods -n default
  ```

- View logs of any pod:

  ```bash
  kubectl logs <pod-name> -n default
  ```

- Check Terraform state and plan output if infrastructure issues occur.
- Confirm Docker images are successfully pushed and accessible in your registries.

---

## Contributing & Support

- For issues, please open a GitHub issue.
- Contact DevOps team: devops@yourcompany.com
- Data engineering questions: dataeng@yourcompany.com

---

## License

MIT License

---

*Happy data engineering! 🚀*
