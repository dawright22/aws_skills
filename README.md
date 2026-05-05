# git-ape-aws-skills

> AWS service skills plugin for [Git-Ape](https://github.com/Azure/git-ape)

Extends Git-Ape with **21 AWS skills** covering compute, storage, databases, networking, security, messaging, AI, and cost estimation.

**Repository:** https://github.com/dawright22/aws_skills

## Install

### Option 1: Copilot Plugin Marketplace (Recommended)

**From Bash:**

```bash
copilot plugin marketplace add dawright22/aws_skills
copilot plugin install git-ape@aws_skills
copilot plugin list   # Should show: git-ape@aws_skills
```

**From within Copilot CLI:**

```bash
# Add the aws_skills plugin from the marketplace
/plugin marketplace add dawright22/aws_skills

# Install it into your workspace
/plugin install git-ape-aws-skills@git-ape-aws-skills

# Verify installation
/plugin list

# Update aws_skills to the latest version
/plugin update dawright22/aws_skills

# Remove aws_skills if no longer needed
/plugin uninstall dawright22/aws_skills
```

### Option 2: Clone and Install

```bash
# Clone the plugin repository
git clone https://github.com/dawright22/aws_skills.git

# Run the install script, targeting your Git-Ape repo
cd aws_skills
./install.sh /path/to/your-git-ape-repo
```

### Option 3: Download and Install

```bash
# Download the latest release
curl -L https://github.com/dawright22/aws_skills/archive/refs/heads/main.zip -o aws_skills.zip
unzip aws_skills.zip
cd aws_skills-main

# Install into your Git-Ape repo
./install.sh /path/to/your-git-ape-repo
```

### Option 4: Manual Copy

```bash
# Clone into your Git-Ape repo's skills directory directly
git clone https://github.com/dawright22/aws_skills.git /tmp/aws_skills
cp -r /tmp/aws_skills/skills/aws-* /path/to/your-git-ape-repo/.github/skills/
rm -rf /tmp/aws_skills
```

## Uninstall

```bash
# Via marketplace
copilot plugin uninstall git-ape-aws-skills

# Via shell script (tracks what was installed for clean removal)
./uninstall.sh /path/to/your-git-ape-repo

# Manual: remove all aws-* skill directories
rm -rf /path/to/your-git-ape-repo/.github/skills/aws-*
```

## Included Skills

| Skill | Category | Description |
|-------|----------|-------------|
| `aws-api-gateway` | Networking | REST and HTTP API management |
| `aws-bedrock` | AI | Foundation models for generative AI |
| `aws-cloudformation` | IaC | Infrastructure as code for stack management |
| `aws-cloudwatch` | Monitoring | Logs, metrics, alarms, and dashboards |
| `aws-cognito` | Security | User authentication and authorization |
| `aws-cost-estimator` | Cost | Monthly cost estimation using AWS Pricing API |
| `aws-dynamodb` | Database | NoSQL database for scalable data storage |
| `aws-ec2` | Compute | Virtual machine management |
| `aws-ecs` | Compute | Container orchestration for Docker |
| `aws-eks` | Compute | Kubernetes cluster management |
| `aws-eventbridge` | Messaging | Serverless event bus |
| `aws-iam` | Security | Identity and access management |
| `aws-lambda` | Compute | Serverless functions |
| `aws-naming-research` | Governance | Resource naming conventions and constraints |
| `aws-rds` | Database | Managed relational databases |
| `aws-s3` | Storage | Object storage and access control |
| `aws-secrets-manager` | Security | Secret storage and rotation |
| `aws-security-analyzer` | Security | CloudFormation security analysis |
| `aws-sns` | Messaging | Pub/sub notification service |
| `aws-sqs` | Messaging | Message queue service |
| `aws-step-functions` | Compute | Workflow orchestration with state machines |

## Prerequisites

- [Git-Ape](https://github.com/Azure/git-ape) installed and configured
- AWS CLI >= 2.0 (`aws --version`)
- Active AWS session (`aws sts get-caller-identity`)

Run `/prereq-check` to validate all prerequisites.

## Usage

After installation, use any AWS skill via Copilot Chat:

```
@git-ape create a Lambda function with S3 trigger
@git-ape estimate costs for my CloudFormation template
@git-ape analyze security of my AWS stack
@git-ape set up an EKS cluster with node groups
```

## Plugin Structure

```
aws_skills/
├── README.md              # This file
├── plugin.json            # Plugin metadata
├── marketplace.json       # Marketplace registry entry
├── install.sh             # Install script
├── uninstall.sh           # Uninstall script
└── skills/                # 21 AWS skill definitions
    ├── aws-api-gateway/
    │   └── SKILL.md
    ├── aws-bedrock/
    │   └── SKILL.md
    ├── aws-cloudformation/
    │   └── SKILL.md
    └── ... (21 total)
```

## License

MIT
