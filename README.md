DevOps Home Assessment – Senior Role
🌐 Objective
Design, deploy, and manage a secure and scalable infrastructure to run a sample web application. This project demonstrates Infrastructure as Code, CI/CD automation, secret management, monitoring, and GitOps.
Architecture Diagram


📁 Project Structure

DevOps_Home_Assessment/
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   └── roles/
├── terraform/
│   ├── envs/
│   ├── modules/
│   └── backend/
├── k8s-manifests/
│   ├── base/
│   ├── overlays/
│   └── argo-rollouts/
├── jenkins/
│   └── pipelines/
├── monitoring/
│   ├── prometheus/
│   └── grafana/
└── README.md


🧰 Tools Used
Category
Tools/Services
Cloud
AWS (VPC, EC2, EKS, S3, Secrets Manager, IAM, CloudWatch)
IaC
Terraform (with remote state in S3 + locking via DynamoDB)
Configuration Mgmt
Ansible (with dynamic inventory via aws_ec2.yml)
CI/CD
Jenkins (multi-branch pipelines), GitHub
GitOps
Argo CD
Observability
Prometheus, Grafana, EFK Stack (Elasticsearch, Filebeat, Kibana, Logstash)
App Monitoring
AppDynamics Agent
Security & Scanning
AWS Secrets Manager, Trivy, SonarQube
Container Registry
Amazon ECR

🚀 Setup Instructions
1. Infrastructure Provisioning:
cd terraform/envs/dev
terraform init
terraform apply
2. Configuration Management:
cd ansible
ansible-playbook -i inventory/aws_ec2.yml playbooks/configure-prometheus-grafana.yml
3. Jenkins Pipeline Configuration:

- Pipelines auto-trigger based on Git branches (dev, staging, prod)
- Environment-specific secrets are pulled securely via AWS Secrets Manager
- Docker images are built, scanned (Trivy), tested (unit, integration), and pushed to ECR
- Kubernetes manifests are stored in Git; ArgoCD auto-syncs (except in prod)


🔐 Secrets Management
Secrets such as RDS passwords and API keys are stored in AWS Secrets Manager. Jenkins retrieves them using scoped IAM roles.

environment {
  DB_USERNAME = credentials('rds-db-username')
  DB_PASSWORD = credentials('rds-db-password')
}


🔁 CI/CD Pipeline
Dev Branch:
- Linting
- Unit Testing
- SonarQube Analysis
- Trivy Image Scan
Staging Branch:
- Integration Testing
- Pre-deployment checks
- Auto-sync via ArgoCD
Prod Branch:
- Manual Approval Stage
- Argo CD Manual Sync
- Post-deployment verification
📈 Monitoring & Observability

- Prometheus and Grafana run on a shared EC2 instance for all environments
- Node Exporter and Kube-State-Metrics collect cluster metrics
- AlertManager triggers alerts on failures
- ELK Stack: Filebeat + Metricbeat forward logs to Elasticsearch for visualization in Kibana


📦 Deployment Strategy

- Argo CD performs GitOps-based rollouts
- Argo Rollouts used for Blue-Green Deployment
- HPA (Horizontal Pod Autoscaler) is configured via K8s manifests


📸 Architecture Diagram
⬇️ Space reserved for: diagram-export-8-4-2025-3_53_33-PM.png
🔒 Security and Compliance Boundaries
Zone
Controls
Secrets
AWS Secrets Manager + IAM Role Scoping + CloudTrail
CI/CD (Jenkins)
RBAC, Script restrictions, Secure plugins, IAM Access Scopes
Kubernetes Clusters
RBAC, IRSA, NetworkPolicies, PSPs/OPA Gatekeeper
GitOps (Argo CD)
RBAC, Manual Prod Sync, Role Bindings
Monitoring EC2
Hardened host, SecGroups, RBAC in Grafana, Encrypted storage
External (AppDynamics)
CoreDNS policy, TLS, SaaS whitelist via egress rules

📘 Assumptions Made

- Each environment (dev/staging/prod) can either be separate EKS clusters or isolated via namespaces
- Jenkins and Argo CD use scoped IAM roles
- All images are assumed to be built using Dockerfiles placed in the app/ directory
- DNS for application is configured outside this repo


❌ Known Limitations

- No full CI/CD rollback mechanism implemented (can be done via Argo Rollout hooks)
- Shared monitoring EC2 may become a bottleneck in very large-scale clusters


💭 Reflection
1. What were 2–3 decisions you made that were not explicitly asked for?

- GitOps-based Deployment using Argo CD
- Centralized Observability Stack on a Shared EC2
- CI/CD Integration of Trivy, SonarQube, and AppDynamics agent embedded in code


2. Why did you make those decisions?

- GitOps simplifies version control, auditability, and declarative deployment
- Central Monitoring reduces cost, simplifies metric correlation across clusters
- AppSec Integration (Trivy, Sonar) adds security gates early in pipeline


3. Were there trade-offs or alternatives you considered?

- Trade-off: Central observability might pose a SPOF; could be distributed via Thanos/Federated Prometheus
- Alternative: Could have used Vault instead of AWS Secrets Manager, but AWS Secrets integrates better with IAM and existing tooling


📎 Submission Details

- GitHub Repo: [Insert GitHub link here]
- Submission includes:
  * Infrastructure as Code (Terraform)
  * Configuration Management (Ansible)
  * CI/CD Pipelines (Jenkins)
  * Kubernetes Manifests (GitOps)
  * Observability Setup
  * README with reflection, security, and setup


✅ Thank you for reviewing this submission!

