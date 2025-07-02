# Multi-Cloud Data Lake & Data Warehouse Project Runbook

## Overview
This project implements a hybrid multi-cloud data platform using AWS and Azure. It includes data lakes (S3, ADLS), data warehouses (Synapse, Redshift), Kafka/Event Hubs, and analytics engines (Spark, Trino) running on Kubernetes.

---

## Prerequisites
- Azure DevOps account with permissions to deploy resources
- AWS account with required permissions for EKS, MSK, S3, IAM, etc.
- Kubernetes clusters: AKS (Azure), optionally EKS (AWS)
- Docker installed locally (for local builds/tests)
- Terraform CLI installed locally or in CI

---

## Deployment Steps

1. **Provision Infrastructure**
   - Run Terraform to create AWS and Azure resources  
   `terraform init && terraform apply`

2. **Build and Push Docker Images**
   - Use Azure DevOps pipeline to build images and push to ACR and AWS ECR

3. **Deploy Applications**
   - Deploy Spark/Trino, Apache Atlas, and Airflow via Helm charts to AKS/EKS clusters

4. **Configure Airflow**
   - Set Airflow connections for AWS S3, Azure ADLS, Kafka, Event Hubs
   - Deploy DAGs into Airflow's DAG folder

5. **Run and Monitor Pipelines**
   - Trigger Airflow DAGs manually or via schedule
   - Monitor logs and metrics via Prometheus/Grafana

---

## Troubleshooting

- **Terraform fails**: Check AWS/Azure credentials and Terraform logs
- **Docker build errors**: Validate Dockerfiles and dependencies
- **Helm deployment issues**: Verify kubeconfig and Helm versions
- **Airflow DAG failures**: Check Airflow logs, connection configurations
- **Kafka/Event Hub issues**: Check network connectivity and topic permissions

---

## CI/CD Pipelines

- Managed via Azure DevOps YAML pipeline `.azure-pipelines.yml`
- Builds and pushes Docker images
- Runs Terraform deployments
- Deploys Helm charts

---

These variables should match the actual resource names created or referenced in your Terraform infrastructure.
Explanation:

    AZURE_RESOURCE_GROUP — The Azure resource group where your AKS cluster is deployed.

    AZURE_AKS_CLUSTER — The AKS cluster name deployed in Azure by your Terraform.

    AZURE_ACR_NAME — The Azure Container Registry name you created via Terraform (or manually) where Docker images will be pushed.

    AWS_REGION — The AWS region where your EKS cluster is deployed (e.g., us-east-1).

    AWS_EKS_CLUSTER — The name of your EKS cluster deployed in AWS via Terraform.

    AWS_ECR_REPO — The AWS Elastic Container Registry repository URI (e.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-repo) you created or Terraform outputs.

How to get these from Terraform?

    Terraform outputs can provide these names if you defined outputs in your Terraform modules. For example:
---
output "aks_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.my_repo.repository_url
}

---

Then after applying Terraform, run:

   terraform output aks_resource_group
   terraform output aks_cluster_name
   terraform output acr_name
   terraform output eks_cluster_name
   terraform output ecr_repo_url