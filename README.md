Production-Ready DevOps Infrastructure (AWS + Terraform + CI/CD + Monitoring)

Project Summary
Membangun end-to-end DevOps pipeline berbasis cloud dengan pendekatan Infrastructure as Code (IaC), automated CI/CD, dan real-time monitoring.
Project ini mensimulasikan environment production dengan multi-environment (dev, staging, prod) untuk memastikan proses deployment yang scalable, repeatable, dan reliable.

Business Impact (What This Project Solves)
    
       - Deployment lebih cepat → dari manual menjadi fully automated (CI/CD)
	   - Consistency antar environment → tidak ada config mismatch (dev vs prod)
	   - Downtime berkurang → karena proses deploy terstandarisasi
	   - Visibility meningkat → monitoring real-time dengan metrics
	   - Security lebih terkontrol → menggunakan security group & network isolation

Key Metrics (Simulated)

Deployment time: ~10–15 menit → < 3 menit
	
    - Manual steps reduced: 80% → 0% (fully automated)
    - Infrastructure provisioning: 100% via Terraform
    - Containerized services: 100%
    - Monitoring coverage: CPU, Memory, Network, Instance health

Architecture Overview

Project mencakup:
	
    - AWS EC2 → compute instance
    - VPC → isolated network
    - Subnet (Public) → resource placement
    - Internet Gateway (IGW) → internet access
    - Route Table (RTB) → traffic routing
    - Security Group → firewall rules
    - Docker → containerization
    - GitHub Actions → CI/CD automation
    - Prometheus → metrics collection
    - Grafana → visualization dashboard

Tech Stack
	
    - Terraform (Infrastructure as Code)
    - AWS (EC2, VPC, Networking)
    - Docker (Containerization)
    - GitHub Actions (CI/CD Pipeline)
    - Prometheus & Grafana (Monitoring & Observability)
    - Linux (Ubuntu Server)

Multi-Environment Strategy

Environment   Purpose

- dev            Development & testing
- staging        Pre-production validation
- prod           Production environment

Setiap environment memiliki konfigurasi terpisah
Mendukung safe deployment & rollback strategy

CI/CD Pipeline Flow

Developer Push Code
        ↓
GitHub Actions Trigger
        ↓
Build Docker Image
        ↓
Push to DockerHub
        ↓
SSH ke EC2
        ↓
Pull Latest Image
        ↓
Restart Container (Zero manual intervention)

Monitoring & Observability

- Prometheus
	- Collect metrics dari Node Exporter
    - Tracking: CPU, Memory, Disk, Network

- Grafana
	- Dashboard visual real-time
	- Alert-ready monitoring system

Security Implementation

    - Security Group rules:
      - SSH (22)
      - HTTP (80)
	     - Grafana (3000)
	     - Prometheus (9090)
	     - Node Exporter (9100)
    - Isolated VPC network
    - Controlled inbound/outbound traffic

Project Structure

aldo-project-devops/
├── .github/
│   └── workflows/
│       └── cicd.yml
├── app/
│   ├── Dockerfile
│   └── index.html
├── terraform/
│   ├── env/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── terraform.tfvars
│   │   │   └── variables.tf
│   │   ├── prod/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── terraform.tfvars
│   │   │   └── variables.tf
│   │   └── staging/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── terraform.tfvars
│   │       └── variables.tf
│   ├── modules/
│   │   ├── ec2/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── vpc/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── .gitignore
      