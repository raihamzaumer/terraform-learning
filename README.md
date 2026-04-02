
# 🚀 Terraform EC2 with SSM & Nginx

This project provisions a secure **AWS EC2 instance** using **Terraform**, with **SSM access enabled** and **Nginx automatically installed** via user data.

## 📌 Overview

This setup eliminates the need for SSH by using **AWS Systems Manager (SSM)** while bootstrapping the instance with **Nginx** for immediate web access.

## ✨ Features

* 💻 EC2 instance provisioning using Terraform
* 🔐 **SSM enabled** (no SSH key required)
* 🌐 **Nginx auto-installed** using user data
* 🛡️ Minimal and secure security group configuration
* ⚙️ Clean and reusable code structure

## ⚙️ How It Works

* EC2 instance is launched
* IAM Role with SSM permissions is attached
* User data script runs on boot:

  * Updates packages
  * Installs Nginx
  * Starts and enables Nginx service

## 📁 Project Structure

```bash
.
├── main.tf
├── variables.tf
├── outputs.tf
```

## 🚀 Usage

```bash
# Initialize
terraform init

# Plan
terraform plan

# Apply
terraform apply

# Destroy
terraform destroy -auto-approve
```

## 🌐 Access

* Nginx will be available via:

  ```
  http://<EC2-Public-IP>
  ```

* Connect to instance using SSM:

  * AWS Console → EC2 → Connect → Session Manager

## 🔐 Security Highlights

* ✅ No SSH port (22) exposed
* ✅ Access via AWS SSM only
* ✅ Least privilege IAM role for SSM
* ✅ HTTP (port 80) enabled for web access

## 📜 User Data (Nginx Setup)

```bash
#!/bin/bash
apt update -y
apt install nginx -y
systemctl start nginx
systemctl enable nginx
```

## 📈 Future Enhancements

* Add HTTPS with Load Balancer
* Attach domain using Route 53
* CI/CD pipeline for automation

## 👨‍💻 Author

**Hamza Umer**
Trainee DevOps Engineer

