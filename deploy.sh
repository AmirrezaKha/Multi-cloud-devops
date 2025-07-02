#!/bin/bash

set -e

echo "=== Starting multi-cloud data lake and warehouse deployment ==="

# Variables - replace these with your own values
AZURE_RESOURCE_GROUP="your-aks-rg"
AZURE_AKS_CLUSTER="your-aks-cluster"
AZURE_ACR_NAME="youracr"
AWS_REGION="your-region"
AWS_EKS_CLUSTER="your-eks-cluster"
AWS_ECR_REPO="your-aws-ecr-repo"

# Docker image tags
AIRFLOW_IMAGE_AZURE="${AZURE_ACR_NAME}.azurecr.io/airflow:latest"
SPARK_TRINO_IMAGE_AZURE="${AZURE_ACR_NAME}.azurecr.io/spark-trino:latest"
ATLAS_IMAGE_AZURE="${AZURE_ACR_NAME}.azurecr.io/atlas:latest"

AIRFLOW_IMAGE_AWS="${AWS_ECR_REPO}/airflow:latest"
SPARK_TRINO_IMAGE_AWS="${AWS_ECR_REPO}/spark-trino:latest"
ATLAS_IMAGE_AWS="${AWS_ECR_REPO}/atlas:latest"

echo
echo "Step 1: Terraform Init & Apply"
cd terraform
terraform init
terraform apply -auto-approve
cd ..

echo
echo "Step 2: Build and Push Docker Images"

echo "-- Azure Container Registry --"
az acr login --name $AZURE_ACR_NAME
docker build -t $AIRFLOW_IMAGE_AZURE docker/airflow
docker push $AIRFLOW_IMAGE_AZURE
docker build -t $SPARK_TRINO_IMAGE_AZURE docker/spark_trino
docker push $SPARK_TRINO_IMAGE_AZURE
docker build -t $ATLAS_IMAGE_AZURE docker/atlas
docker push $ATLAS_IMAGE_AZURE

echo "-- AWS Elastic Container Registry --"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ECR_REPO
docker build -t $AIRFLOW_IMAGE_AWS docker/airflow
docker push $AIRFLOW_IMAGE_AWS
docker build -t $SPARK_TRINO_IMAGE_AWS docker/spark_trino
docker push $SPARK_TRINO_IMAGE_AWS
docker build -t $ATLAS_IMAGE_AWS docker/atlas
docker push $ATLAS_IMAGE_AWS

echo
echo "Step 3: Get Kubernetes Credentials"

echo "-- Azure AKS --"
az aks get-credentials --resource-group $AZURE_RESOURCE_GROUP --name $AZURE_AKS_CLUSTER

echo "-- AWS EKS --"
aws eks update-kubeconfig --region $AWS_REGION --name $AWS_EKS_CLUSTER

echo
echo "Step 4: Deploy Helm Charts"

helm upgrade --install spark-trino ./modules/spark_trino/helm_chart --namespace default
helm upgrade --install atlas ./modules/atlas/helm_chart --namespace default
helm upgrade --install airflow ./modules/airflow/helm_chart --namespace default

echo
echo "Step 5: Deploy Airflow DAGs"
echo "Copy your DAGs folder content to Airflow's DAGs folder or configure Git-sync in Airflow."

# Optional example if DAGs mounted via PVC and path known:
# cp dags/*.py /path/to/airflow/dags/

echo
echo "=== Deployment Complete! ==="
echo "Access Airflow UI via Kubernetes service or ingress."
