README: Setting Up Google SDK, CLI, and Kubernetes Plugins
Setup Google SDK and CLI with Kubernetes Plugins
gcloud CLI Configuration
Install the Google Cloud CLI using the following command: sudo snap install google-cloud-cli --classic. Authenticate with gcloud auth login and set the project using gcloud config set project qwiklabs-gcp-02-ea4ca0d66fa5. Install the Google Cloud SDK with sudo snap install google-cloud-sdk --classic.

gcloud SDK Installation
Install necessary prerequisites: sudo apt-get install apt-transport-https ca-certificates gnupg -y. Add Google Cloud SDK to the package sources using: echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list. Import the keyring: curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -. Update packages and install the CLI: sudo apt-get update && sudo apt-get install google-cloud-cli. Finally, install additional plugins with sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin and initialize with gcloud init.

Kubernetes Configuration
Install kubectl and related plugins using gcloud components install kubectl and gcloud components install gke-gcloud-auth-plugin. Ensure the Google Kubernetes Engine authentication plugin is installed using sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin.

Create GKE Cluster in Google Cloud
Step 1: Clone the Repository and Configure
Clone the repository with git clone https://github.com/Pruthvi360/ci-cd-build-kubernetes.git and navigate to the Terraform directory using cd ci-cd-build-kubernetes/terraform-gke. Create a service account in Google Cloud with Kubernetes Admin, Compute Admin, and Service Account User privileges. Download and save the JSON key in the Terraform directory.

Step 2: Install Terraform
Install Terraform using the command: sudo snap install terraform --classic.

Step 3: Initialize Terraform
Initialize Terraform with terraform init. Plan and apply the configuration with terraform plan -var "project_id=<your-project-id>" and terraform apply -var "project_id=<your-project-id>" -auto-approve.

Step 4: Connect to the GKE Cluster
Authenticate and retrieve credentials for the cluster using gcloud container clusters get-credentials <gke-cluster-name> --region us-central1 --project <project_id>.

Step 5: Verify the Setup
List cluster nodes with kubectl get nodes and verify running pods using kubectl get pods.

Step 6: Destroy Infrastructure
Clean up resources by running terraform destroy -var "project_id=<your-project-id>" -auto-approve.

GKE Cluster Configuration
Set the active project using gcloud config set project <project-id>. Retrieve cluster credentials with gcloud container clusters get-credentials <cluster-name> --region <region>. Verify the current Kubernetes context with kubectl config current-context and test connectivity by listing nodes using kubectl get nodes.

Deploy Helm Chart to GKE Cluster
Ensure the Kubernetes context points to your GKE cluster using gcloud container clusters get-credentials <cluster-name> --region <region>. Install Helm following the official guide. Navigate to your Helm chart directory: cd <chart-directory>. Deploy the Helm chart using helm install <release-name> ./<chart-directory>. Verify the deployment with kubectl get all and retrieve the external IP for LoadBalancer services using kubectl get svc <service-name>. Access your application through http://<EXTERNAL-IP>:<PORT>.

Key Components Overview
The binding process includes the Kubernetes Provider, which connects Terraform to Kubernetes clusters, and the Helm Provider, which manages Helm charts. The Helm Release Resource specifies the chart location and configuration while managing lifecycle operations like upgrades and deletions.

By following these instructions, you can effectively set up, deploy, and manage your GKE cluster and Kubernetes resources.
