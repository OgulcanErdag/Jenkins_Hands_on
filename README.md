<p align="center">
  <img src="./jenkins-hands-on-banner.svg" alt="Jenkins Hands-On Labs Banner" width="100%"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white" alt="Jenkins"/>
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white" alt="AWS"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
  <img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes"/>
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux"/>
  <img src="https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white" alt="Maven"/>
  <img src="https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black" alt="Tomcat"/>
</p>

<h3 align="center">🔧 End-to-end Jenkins CI/CD Labs — from installation to Kubernetes deployments</h3>

---

## 📋 Overview

This repository contains a comprehensive series of **Jenkins CI/CD hands-on labs**, progressing from basic installation to advanced pipeline architectures including Multibranch Pipelines and Kubernetes deployments. All labs are built on **AWS EC2 (Amazon Linux 2023)** infrastructure, provisioned with **Terraform** where applicable.

Each session builds on the previous one, creating a structured learning path that mirrors real-world DevOps workflows.

---

## 🗂️ Lab Structure

| #   | Session                                                                                         | Topic                                      | Key Concepts                                              |
| --- | ----------------------------------------------------------------------------------------------- | ------------------------------------------ | --------------------------------------------------------- |
| 🏗️  | **[create-jenkins-server-tf](./create-jenkins-server-tf/)**                                     | Jenkins Server Provisioning with Terraform | IaC, AWS EC2, user-data, Security Groups                  |
| 01  | **[Session-1-installing-jenkins](./Session-1-installing-jenkins/)**                             | Installing Jenkins on Amazon Linux 2023    | Jenkins setup, Freestyle Jobs, Build Steps                |
| 02  | **[Session-2a-triggers](./Session-2a-triggers/)**                                               | Triggering Jenkins Jobs                    | Poll SCM, GitHub Webhooks, Build Triggers                 |
| 03  | **[Session-2b-maven](./Session-2b-maven/)**                                                     | Java & Maven Jobs in Jenkins               | Maven builds, JDK config, Declarative Pipelines           |
| 04  | **[Session-3a-tomcat](./Session-3a-tomcat/)**                                                   | Tomcat Installation & Configuration        | Staging/Production setup, WAR deployment                  |
| 05  | **[Session-3b-Deployment](./Session-3b-Deployment/)**                                           | Deploying to Staging/Production            | Publish Over SSH, Automated Deployment                    |
| 06  | **[Session-4-agent-node&DSL-job](./Session-4-agent-node%26DSL-job/)**                           | Agent Nodes & DSL Jobs                     | Distributed builds, Jenkins DSL, Node config              |
| 07  | **[Session-5-Folder-MultibranchPipeline](./Session-5-Folder-MultibranchPipeline/)**             | Folders & Multibranch Pipeline             | Jenkins Folders, Branch discovery, Jenkinsfile per branch |
| 08  | **[jenkins-07_kubernetes-project-with-jenkins](./jenkins-07_kubernetes-project-with-jenkins/)** | Kubernetes Deployment Pipeline             | ECR, Docker build, K8s manifests, Full CI/CD              |

---

## 🛠️ Tech Stack

- **CI/CD:** Jenkins (Freestyle, Pipeline, Multibranch Pipeline, DSL)
- **Cloud:** AWS (EC2, ECR, Security Groups, IAM)
- **IaC:** Terraform
- **Containers:** Docker, Kubernetes (kubeadm)
- **Build Tools:** Maven, Java (JDK)
- **Deployment:** Tomcat, Publish Over SSH, K8s manifests
- **OS:** Amazon Linux 2023

---

## 🚀 Learning Path

```
┌─────────────────────────────────────────────────────────────────┐
│  1. SETUP          Terraform → EC2 → Jenkins Installation       │
├─────────────────────────────────────────────────────────────────┤
│  2. BASICS         Freestyle Jobs → Triggers → Webhooks         │
├─────────────────────────────────────────────────────────────────┤
│  3. BUILD          Maven → Java → Declarative Pipelines         │
├─────────────────────────────────────────────────────────────────┤
│  4. DEPLOY         Tomcat → Staging → Production (SSH)          │
├─────────────────────────────────────────────────────────────────┤
│  5. SCALE          Agent Nodes → DSL Jobs → Distributed Builds  │
├─────────────────────────────────────────────────────────────────┤
│  6. ADVANCED       Folders → Multibranch Pipeline               │
├─────────────────────────────────────────────────────────────────┤
│  7. KUBERNETES     Docker → ECR → K8s Deployment Pipeline       │
└─────────────────────────────────────────────────────────────────┘
```

---

## ⚙️ Prerequisites

- AWS Account with EC2 access
- Terraform installed locally
- Basic Linux command line knowledge
- GitHub account (for webhook-based triggers)
- Docker & Kubernetes fundamentals (for Session 07–08)

---

## 👤 Author

**Ogulcan Erdag**

[![Portfolio](https://img.shields.io/badge/Portfolio-ogulcan--erdag.com-0A0A0A?style=for-the-badge&logo=googlechrome&logoColor=white)](https://ogulcan-erdag.com)
[![GitHub](https://img.shields.io/badge/GitHub-OgulcanErdag-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/OgulcanErdag)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ogulcan-erdag/)

---

## 📄 License

This project is for educational purposes. All labs were built and documented hands-on as part of my DevOps learning journey.
