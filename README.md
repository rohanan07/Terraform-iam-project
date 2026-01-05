# AWS IAM User Management with Terraform

This project demonstrates how to manage AWS IAM users and access securely using **Terraform**.  
It is a learning-focused project built by first understanding the concepts and then implementing them — not just copying code.

The base setup was inspired by a YouTube video by **Piyush Sachdeva**, where IAM users, groups, and group memberships were implemented. I followed the same approach, made sure I understood each resource, and then extended the project with additional security-focused features.

---

## What the base setup includes (from the video)

- IAM user creation
- IAM groups
- Adding users to groups
- Terraform project structure and workflow

---

## What I implemented additionally

- **MFA enforcement** using IAM policies attached at the group level  
- **Custom IAM policies** for each group (Education, Engineers, Managers)  
- **Secure password handling** using **AWS Secrets Manager**:
  - Temporary IAM passwords are stored securely
  - Password reset is forced on first login

These additions helped me understand IAM from a real-world security and access-design perspective.

---

## What is not implemented yet

- AWS SSO for centralized identity management  
- Automated onboarding integrated with HR systems  

These involve more advanced enterprise identity setups and are planned for future learning.

---

## Project Structure
backend.tf # Remote backend (S3) and state locking
provider.tf # AWS provider configuration
variables.tf # Input variables
locals.tf # Local values
data.tf # Data sources
users.csv # User data source
main.tf # IAM user creation
groups.tf # IAM groups and group memberships
policies.tf # Custom IAM policies
secretsmanager.tf # Secrets Manager integration
outputs.tf # Terraform outputs


---

##Architecuture Diagram:
![Architecture Diagram](https://github.com/rohanan07/Terraform-iam-project/blob/main/Terraform%20Iam%20project%20architecture.png)

## Key Learnings

- IAM is more about **secure access design** than just permissions
- Group-based access scales much better than user-based permissions
- Terraform enforces good security practices (especially with sensitive data)
- Secrets Manager is for **secure storage**, not password distribution
- Clean Terraform structure makes projects easier to understand and maintain

---

## Disclaimer

This is a **learning project**, not a production-ready IAM solution.  
The goal was to understand AWS IAM and Terraform fundamentals properly and apply them in a realistic way.

---

## Credits

- **Piyush Sachdeva** — for the original tutorial and explanation


