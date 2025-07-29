
# Azure Infrastructure as Code (AVD & All Azure Modules)

This repository provides a modular, production-ready Terraform implementation for deploying and managing Azure resources—including, but not limited to, Azure Virtual Desktop (AVD). Each major Azure component (AVD, networking, storage, identity, monitoring, etc.) is implemented as a reusable module under `modules/`.

## Overview
- **Modular Design:** Each major AVD component (host pools, workspaces, application groups, image build, diagnostics, etc.) is implemented as a reusable Terraform module under `modules/`.
- **YAML-Driven:** Supports YAML configuration for flexible, declarative infrastructure management.
- **CI/CD Ready:** Includes Azure Pipelines YAML for automated validation and GitHub sync.
- **Best Practices:** Follows security, scalability, and maintainability standards for enterprise deployments.

## Repository Structure
- `modules/` – All core and supporting Terraform modules
- `.azure-pipelines/` – Azure DevOps pipeline YAML for CI/CD
- `README.md` – (This file) Repository documentation

## Getting Started
1. Clone this repository.
2. Review the `sample_setup/` folder for example usage and YAML definitions.
3. Customize variables and YAML files as needed for your environment.
4. Use the provided Azure Pipeline to automate validation and GitHub sync.

## Best Practices
- Never commit sensitive values or Terraform state files.
- Always add `.terraform/` to `.gitignore` to avoid large provider files.
- Use modules for reusability and maintainability.
- Validate changes in a non-production environment before deployment.

## References
- [Azure Virtual Desktop Documentation](https://docs.microsoft.com/en-us/azure/virtual-desktop/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)


---
**Author:** workwithme@saiobili.com  
* PRs and issues welcome!*

---
**Note:** This repository is designed to be extended with modules for all Azure resources. Follow the same modular and documentation standards for each new resource you add.
