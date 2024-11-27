
# **IPFS Metadata Service**

This project provides a containerized Golang application that reads IPFS CIDs from a CSV file, stores them in a PostgreSQL database, and exposes an API to retrieve the stored data. The project includes Dockerization, CI/CD workflows, and Infrastructure as Code (IaC) using Terraform for deployment on AWS.

---

## **Table of Contents**
1. [Features](#features)
2. [Requirements](#requirements)
3. [Setup](#setup)
   - [Clone the Repository](#clone-the-repository)
   - [Docker Instructions](#docker-instructions)
4. [CI/CD Workflow](#ci/cd-workflow)
5. [Infrastructure Deployment (Terraform)](#infrastructure-deployment-terraform)
6. [Assumptions](#assumptions)
7. [Troubleshooting](#troubleshooting)
8. [Acknowledgments](#acknowledgments)

---

## **Features**
- Containerized Golang application using Docker.
- CI/CD pipeline using GitHub Actions to build and push the Docker image to Amazon ECR.
- Infrastructure deployment using Terraform, including:
  - AWS VPC, subnets, and security groups.
  - ECS cluster to host the application.
  - PostgreSQL database on AWS RDS.

---

## **Requirements**
- **Tools**:
  - Docker
  - Terraform
  - AWS CLI
  - GitHub account with Actions enabled
- **AWS Account** with appropriate permissions for:
  - ECR (Elastic Container Registry)
  - ECS (Elastic Container Service)
  - RDS (Relational Database Service)

---

## **Setup**

### **1. Clone the Repository**
Fork and clone the project repository:
git clone https://github.com/<your-github-username>/ipfs-metadata.git
cd ipfs-metadata


---

### **2. Docker Instructions**

#### **Build the Docker Image**
```bash
docker build -t ipfs-metadata .
```

#### **Run the Docker Container**
Ensure you have a `.env` file in the project directory with the following content:
```plaintext
DB_HOST=<your-database-host>
DB_PORT=5432
DB_USER=<your-database-username>
DB_PASSWORD=<your-database-password>
DB_NAME=<your-database-name>
```

Run the container:
```bash
docker run -d -p 8080:8080 --env-file .env ipfs-metadata
```

Verify the application is running:
```bash
curl http://localhost:8080
```

---

## **3. CI/CD Workflow**

This project uses GitHub Actions to automate Docker image builds and pushes to Amazon ECR.

### **Triggering the Workflow**
1. Ensure your repository has the following GitHub secrets configured:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. Push changes to the `main` branch to trigger the workflow.

The workflow:
- Builds the Docker image.
- Pushes the image to your ECR repository.

---

## **4. Infrastructure Deployment (Terraform)**

### **Setup AWS Credentials**
Configure AWS CLI:
```bash
aws configure
```

### **Initialize Terraform**
Navigate to the Terraform directory:
```bash
cd terraform
terraform init
```

### **Deploy Infrastructure**
```bash
terraform plan
terraform apply
```

### **Components Deployed**
- **VPC** with public and private subnets.
- **ECS** cluster running the containerized application.
- **RDS** PostgreSQL database.

---

## **5. Assumptions**
1. The `.env` file contains valid database credentials.
2. AWS credentials with necessary permissions are properly configured.
3. The application is deployed in a single AWS region (`us-east-1` by default).

---

## **6. Troubleshooting**

### **Common Issues**
1. **Docker Build Errors**:
   - Ensure you’ve cloned the repository and `go.mod`/`go.sum` files are present.
2. **Permission Errors**:
   - Ensure the `main` binary has executable permissions:
     ```bash
     chmod +x ./main
     ```
3. **Environment Variables**:
   - Verify `.env` values match your database and environment setup.