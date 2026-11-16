# TerraformPractice

Practice Terraform project for Azure (`azurerm` provider), set up following common best practices.

## Layout

```
.
├── modules/                  # Reusable, environment-agnostic modules
│   └── network/              # VNet + subnets
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── README.md
└── environments/             # One root module per environment (separate state)
    ├── dev/
    │   ├── backend.tf        # Remote state config (commented out until set up)
    │   ├── providers.tf
    │   ├── versions.tf       # Terraform + provider version constraints
    │   ├── variables.tf
    │   ├── locals.tf         # Naming + tagging conventions
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── terraform.tfvars.example
    └── prod/                 # Same shape as dev
```

## Conventions

- **One state per environment.** Each folder under `environments/` is its own root module, so a mistake in dev can't touch prod state.
- **Modules don't configure providers.** They only declare `required_providers`; the provider is configured in the root module.
- **Version pinning.** Root modules pin `~> 4.0`; modules declare a wider compatible range. Commit `.terraform.lock.hcl` after `terraform init`.
- **No secrets in git.** `*.tfvars` and state files are gitignored; only `*.tfvars.example` is committed. Authenticate with `az login` or `ARM_*` environment variables.
- **Consistent naming and tags** come from `locals.tf` (`<project>-<environment>-<resource>`).
- Every variable and output has a `description` and an explicit `type`.

## Usage

```sh
cd environments/dev
cp terraform.tfvars.example terraform.tfvars   # then edit
export ARM_SUBSCRIPTION_ID="<subscription-id>"
az login

terraform init
terraform fmt -recursive
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## Remote state

`backend.tf` is commented out, so state stays local for now. To share state:
1. Create a resource group, a storage account, and a `tfstate` container (one time).
2. Fill in and uncomment `backend.tf` in each environment.
3. Run `terraform init -migrate-state`.
