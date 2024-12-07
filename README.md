
## 18) setup google sdk and cli and install kubectl plugins

## 18.1) gcloud CLI configuration
```
sudo snap install google-cloud-cli --classic

gcloud auth login

gcloud config set project qwiklabs-gcp-02-ea4ca0d66fa5

sudo snap install google-cloud-sdk --classic
```
## 18.2) gcloud SDK installation parts
```
sudo apt-get install apt-transport-https ca-certificates gnupg -y

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update && sudo apt-get install google-cloud-cli

sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

gcloud init
```

## 18.3) kubernetes configuration 
```
gcloud components install kubectl

gcloud components install gke-gcloud-auth-plugin

sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin
```

## 18.4) Create GKE cluster in the google cloud


## Step 1
```
git clone https://github.com/Pruthvi360/ci-cd-build-kubernetes.git
cd ci-cd-build-kubernetes/terraform-gke
```
```
Create service account in the gcloud account and give 
1. kubernetes admin privilege
2. compute admin privilege
3. service account user privilege
```

## Create service-account json key
```
Download the json key and keep in the terraform dir
```
## Step 2
## install terraform
```
sudo snap install terraform --classic
```
## Step 3
## Terraform init

```
terraform init
terraform plan -var "project_id=<your-project-id>"
terraform apply -var "project_id=<your-project-id>" -auto-approve
```

## Step 4

```
gcloud container clusters get-credentials <gke-cluster-name> --region us-central1 --project <project_id>
```

## Step 5

```
kubectl get nodes
kubectl get pods
```

## Step 6

```
terraform destroy -var "project_id=<your-project-id>" -auto-approve
```

GKE Cluster Setup
1. Set the Active Project
Specify the project containing your GKE cluster:

bash
Copy code
gcloud config set project <project-id>
Example:


gcloud config set project gke-demo-443919
2. Retrieve Cluster Credentials
Fetch and store the GKE cluster’s authentication details in your local kubeconfig file (~/.kube/config):


gcloud container clusters get-credentials <cluster-name> --region <region>
Example:


gcloud container clusters get-credentials gke-demo-443919-gke --region us-east1
3. Verify the Context
Ensure that your kubectl context is set to your GKE cluster:


kubectl config current-context
4. Test Connectivity
Verify that you can interact with your cluster:


kubectl get nodes
Deploy Helm Chart to GKE Cluster
1. Ensure Cluster Context
Make sure your kubectl context points to your GKE cluster:


gcloud container clusters get-credentials <cluster-name> --region <region>
Example:


gcloud container clusters get-credentials gke-demo-443919-gke --region us-east1
2. Install Helm (if not installed)
Install Helm using the official installation guide: https://helm.sh/docs/intro/install/

3. Navigate to Your Chart Directory
Move to the directory where your Helm chart is located:


cd <chart-directory>
Example:


cd ~/ci-cd-build-kubernetes/three-tier-app
4. Deploy the Helm Chart
Use the helm install command to deploy your application:


helm install <release-name> ./<chart-directory>
Example:


helm install three-tier-app ./three-tier-app
5. Verify Deployment
Check the status of all Kubernetes resources:


kubectl get all
6. Access Your Application
For services with a LoadBalancer type, get the external IP:

bash
Copy code
kubectl get svc <service-name>
Example:


kubectl get svc web-deployment
Access your application using the URL:


http://<EXTERNAL-IP>:<PORT>
Understanding Key Components
Binding
Kubernetes Provider: Connects Terraform to your Kubernetes cluster.
Helm Provider: Uses Kubernetes connections to deploy and manage Helm charts.
Helm Release Resource
Specifies the Chart: Points to the Helm chart and defines its configuration.
Manages the Lifecycle: Handles operations such as installation, upgrades, and deletion.
Follow these instructions to set up your GKE cluster, deploy your Helm chart, and manage your Kubernetes resources effectively.
