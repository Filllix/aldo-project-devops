 Production-Ready DevOps Infrastructure

AWS + Terraform + Docker + GitHub Actions + Monitoring

 Project Summary

Project ini membangun end-to-end DevOps pipeline berbasis cloud dengan pendekatan Infrastructure as Code, automated CI/CD, dan monitoring. Repo ini mensimulasikan environment production dengan multi-environment: dev, staging, dan prod.

Production deployment menggunakan branch main, sedangkan development dan staging menggunakan branch dev dan staging.

 Business Impact

- Deployment lebih cepat dari proses manual menjadi automated CI/CD.
- Consistency antar environment karena infrastructure didefinisikan dengan Terraform.
- Downtime berkurang karena production deployment memakai strategi blue-green dengan Nginx reverse proxy.
- Visibility meningkat melalui monitoring Prometheus, Grafana, dan Node Exporter.
- Security lebih terkontrol melalui VPC, subnet, security group, dan pembatasan akses monitoring.

 Key Metrics (Simulated)

- Deployment time: sekitar 10-15 menit menjadi kurang dari 3 menit.
- Manual deployment steps: dikurangi hingga 0 pada proses CI/CD.
- Infrastructure provisioning: 100% via Terraform.
- Containerized services: 100%.
- Monitoring coverage: CPU, memory, disk, network, dan instance health.

 Architecture Overview

Project mencakup:

- AWS EC2 sebagai compute instance.
- VPC sebagai isolated network.
- Public subnet untuk resource placement.
- Internet Gateway untuk internet access.
- Route Table untuk traffic routing.
- Security Group sebagai firewall rules.
- Docker untuk containerization.
- GitHub Actions untuk CI/CD automation.
- Prometheus untuk metrics collection.
- Grafana untuk dashboard monitoring.

 Tech Stack

- Terraform
- AWS EC2, VPC, Subnet, Internet Gateway, Route Table, Security Group
- Docker
- GitHub Actions
- Prometheus, Grafana, Node Exporter
- Ubuntu Server

 Multi-Environment Strategy

| Environment | Branch | Purpose |
| --- | --- | --- |
| dev | dev | Development and testing |
| staging | staging | Pre-production validation |
| prod | main | Production deployment |

Setiap environment memiliki konfigurasi Terraform terpisah dan mendukung deployment yang lebih aman serta mudah di-rollback.

 CI/CD Pipeline Flow

```text
Developer push code
  -> GitHub Actions trigger
  -> Build Docker image
  -> Push image to DockerHub
  -> SSH to EC2
  -> Pull latest image
  -> Deploy idle blue/green container
  -> Run healthcheck
  -> Switch Nginx traffic
  -> Remove old container after success
```

 Required GitHub Secrets

| Secret | Description |
| --- | --- |
| DOCKER_USERNAME | DockerHub username |
| DOCKER_PASSWORD | DockerHub password or access token |
| EC2_SSH_KEY | Private SSH key for EC2 access |
| EC2_HOST_DEV | Public host/IP for dev EC2 |
| EC2_HOST_STAGING | Public host/IP for staging EC2 |
| EC2_HOST_PROD | Public host/IP for prod EC2 |

 Monitoring and Observability

- Prometheus collects metrics from Node Exporter.
- Grafana visualizes infrastructure and application metrics.
- Monitoring ports are restricted to the VPC CIDR in Terraform.
- For public access to Grafana, use an SSH tunnel, VPN, or a secured reverse proxy.

 Security Implementation

- SSH access is controlled through admin_cidr_blocks in the EC2 Terraform module.
- Application ports 8080 and 8081 are public for demo deployment access in dev and staging.
- Production exposes only port 80 through Nginx. App containers stay private inside the Docker `bluegreen` network.
- Grafana 3000, Prometheus 9090, and Node Exporter 9100 are restricted to the VPC CIDR.
- VPC and subnet isolate the infrastructure layer.
- Security group rules are defined as code and can be reviewed before apply.

For a real deployment, replace the default SSH CIDR with your public IP, for example:

```hcl
admin_cidr_blocks = ["203.0.113.10/32"]
```

 Production Blue-Green Deployment

Production branch `main` deploys with this flow:

1. GitHub Actions builds and pushes `${DOCKER_USERNAME}/devops-app:prod`.
2. The EC2 deploy job checks which container is currently active from Nginx config.
3. The new image is started on the idle color, either `app-blue` or `app-green`.
4. The idle container must pass an internal healthcheck before any traffic is switched.
5. Nginx updates `/etc/nginx/conf.d/default.conf` to point to the healthy target container and reloads.
6. The old active container is removed only after the new route responds successfully.

Rollback is simple: rerun the previous successful workflow commit or manually switch Nginx back to the other color if that container still exists.

 Project Structure

```text
aldo-project-devops/
|
|-- .github/
|   `-- workflows/
|       `-- cicd.yml
|
|-- app/
|   |-- Dockerfile
|   `-- index.html
|
`-- terraform/
    |-- env/
    |   |-- dev/
    |   |   |-- main.tf
    |   |   |-- outputs.tf
    |   |   |-- terraform.tfvars
    |   |   `-- variables.tf
    |   |-- staging/
    |   |   |-- main.tf
    |   |   |-- outputs.tf
    |   |   |-- terraform.tfvars
    |   |   `-- variables.tf
    |   `-- prod/
    |       |-- main.tf
    |       |-- outputs.tf
    |       |-- terraform.tfvars
    |       `-- variables.tf
    |
    `-- modules/
        |-- ec2/
        |   |-- main.tf
        |   |-- variables.tf
        |   `-- outputs.tf
        |
        `-- vpc/
            |-- main.tf
            |-- variables.tf
            `-- outputs.tf
```
