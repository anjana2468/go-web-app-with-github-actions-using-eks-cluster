# Go Web App - CI/CD Pipeline with GitHub Actions, DockerHub, ArgoCD, and Kubernetes

This project implements a CI/CD pipeline and GitOps-based deployment workflow for a simple Go web application.  
It uses **GitHub Actions**, **DockerHub**, **Helm**, **ArgoCD**, and **Kubernetes**.

## Project Workflow

- **Source Repository**: Go web application source code.
- **GitHub Actions**: Builds Docker images and pushes them to DockerHub.
- **DockerHub**: Hosts the built Docker images.
- **GitOps Repository**: Hosts the Helm chart with updated image versions.
- **ArgoCD**: Automatically syncs the Kubernetes cluster based on GitOps repo changes.

Step-by-Step Implementation

### Step 1: Create a Dockerfile:

- Define the build environment using a Golang image.
- Compile the application in the build stage.
- Copy the compiled binary to a minimal base image (like alpine).

![Screenshot 2025-04-23 123220](https://github.com/user-attachments/assets/4248c596-fe19-4749-befb-cc742705539d)

### Step 2: Build and Run and push the Docker Image to Docker Registry:
```
- docker build -t 8217089795/go-web-app:v1 .
- docker run -p 8081:8081 -it 8217089795/go-web-app:v1
- docker push 8217089795/go-web-app:v1
```
2. Kubernetes Manifests
Kubernetes manifests define the desired state of your application. We’ll create manifests for Deployments, Services, and Ingress.




### Step 3. Continuous Integration with GitHub Actions
GitHub Actions allows you to automate the building and testing of your application whenever changes are pushed to your repository.

Example Workflow File (.github/workflows/ci.yml)
Define a CI Pipeline:
![Screenshot 2025-04-23 160023](https://github.com/user-attachments/assets/9b11eedf-fb5b-4cab-a51c-4d3608c4db8f)




### Step 4. Continuous Delivery with Argo CD
- Argo CD automates the deployment of the application to your Kubernetes cluster based on the state of your Git repository.

![Screenshot 2025-04-22 203741](https://github.com/user-attachments/assets/937fe6bd-a6c3-4f4f-b214-989d108d1d2f)

Setting Up Argo CD
Install Argo CD on your Kubernetes cluster.
Connect Argo CD to your GitHub Repository to monitor for changes and automatically deploy updates.

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Access the Argo CD UI (Loadbalancer service)
kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}

Get the Loadbalancer service IP
kubectl get svc argocd-server -n argocd

### Step 5. Kubernetes Cluster Creation and Setup
For this demonstration, I used EKS to create a Kubernetes cluster.

eksctl create cluster --name demo-cluster --region us-west-2

### Step 6. Helm Chart Creation and Configuration
Helm simplifies the management of Kubernetes applications by packaging them into charts.

Create a Helm Chart
Step 1: Initialize a Helm Chart:
helm create go-web-app-chart

Step 2: Customize Values for Different Environments:
Define different configurations for development, staging, and production environments in the values.yaml file.

7. Ingress Controller and DNS Mapping
Ingress controllers route external traffic to services within the cluster.

Set Up an Ingress Controller
Deploy NGINX Ingress Controller on EKS:

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml
![Screenshot 2025-04-23 153944](https://github.com/user-attachments/assets/772ee407-0974-45e5-ac33-ea8c41cc8a03)

8. End-to-End CI/CD Demonstration
Now that everything is set up, let’s demonstrate the full CI/CD pipeline:

Push Code to GitHub: Trigger the GitHub Actions pipeline to build, test, and push Docker images.
Argo CD Deployment: Argo CD detects changes in the Git repository and automatically syncs the application state to the Kubernetes cluster.
Access the Application: Use the Ingress URL or mapped DNS to access the running application.

![Screenshot 2025-04-22 161421](https://github.com/user-attachments/assets/a932482c-79b0-499a-9aeb-9fcb81e8339c)
[Screenshot 2025-04-22 161438](https://github.com/user-attachments/assets/18b6f343-f3b6-4a03-8ca6-eb3027af001c)
![Screenshot 2025-04-22 161339](https://github.com/user-attachments/assets/653a0f8d-625a-458f-a409-59c7721ce7fc)

















