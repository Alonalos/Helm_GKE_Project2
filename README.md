
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

## 19) Create GKE Kubernetes container
```
gcloud beta container --project "<Project-id>" clusters create "ci-cd" --zone "us-central1-c" --no-enable-basic-auth --cluster-version "1.25.7-gke.1000" --release-channel "regular" --machine-type "e2-medium" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --max-pods-per-node "110" --num-nodes "3" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias --network "projects/qwiklabs-gcp-03-b499196e43ab/global/networks/default" --subnetwork "projects/qwiklabs-gcp-03-b499196e43ab/regions/us-central1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "us-central1-c"
```
## 20) deploy dokcer image to kubernetes 
```
gcloud container clusters get-credentials ci-cd --zone us-central1-c --project <project-id>
```
## 20.1) Create deployment and service YAML files
```
nano deployment.yaml
```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ci-cd
  labels:
     app: myfirst-app

spec:
  replicas: 2
  selector:
    matchLabels:
      app: myfirst-app

  template:
    metadata:
      labels:
        app: myfirst-app

    spec:
      containers:
      - name: myfirst-app
        image: pruthvidevops/deveops:app-v1
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```
```
nano service-expose.yaml
```
```
apiVersion: v1
kind: Service
metadata:
  name: ci-cd-service
  labels:
    app: myfirst-app
spec:
  selector:
    app: myfirst-app
    
  ports:
    - port: 8080
      targetPort: 8080

  type: LoadBalancer
  ```
## 20.2) deploy the deployment.yaml and service-expose.yaml
```
kubectl apply -f deployment.yaml

watch kubectl get pods

kubectl apply -f service-expose.yaml

watch kubectl get svc
```
## 21) Create a jenkins JOB

1. Create and new job with by copying the previous **docker build and push JOB**
2. add EXEC commands
```
echo -e "FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps" > Dockerfile ;

ansible-playbook /etc/ansible/docker.yaml

gcloud container clusters get-credentials ci-cd --zone us-central1-c --project qwiklabs-gcp-02-701d60ba3040

kubectl delete deployment ci-cd
kubectl apply -f deployment.yaml
kubectl apply -f service-expose.yaml
```

## 21.1) Commit from the local repo
```
git init
git pull
git add .
git commit -m "Deploying to kubernetes"
git push
```
**Do Some changes in the index.jsp and perform the above steps**

## 22) After completion of the jenkins JOB

```
kubectl get svc
```
```
http:<LoadBalaner-ip>:8080/webapp/
```
##-------------**NOW YOU SUCCESSFULLY ESTABLISHED THE CI-CD PIPELINE FOR THE ENTIRE DEPLOYMENT**--------------##

##-------------------------------------**THANKS FOR WATCHING**----------------------------------------------##
