module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  # Basic config
  name = "${var.env}-vpc"
  cidr = var.vpc_cidr

  # Availability Zones
  azs = ["us-east-1a", "us-east-1b"]

  # Subnets
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]

  # NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  # DNS support for EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Required subnet tags for EKS
  public_subnet_tags = {
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/${var.env}-eks" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/${var.env}-eks" = "shared"
  }

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}

# ── EKS Cluster — community registry module ────────────────────────
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # Cluster identity
  cluster_name    = "${var.env}-eks-cluster"
  cluster_version = "1.32"

  # Place the cluster in our VPC private subnets
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # Allow your machine to reach the cluster API
  cluster_endpoint_public_access = true

  # Let the Terraform caller (you) administer the cluster
  enable_cluster_creator_admin_permissions = true

  # Managed node group — EC2 worker nodes
  eks_managed_node_groups = {
    default = {
      name           = "${var.env}-node-group"
      instance_types = ["t3.medium"] # ~$0.0416/hr each

      min_size     = 1
      max_size     = 3
      desired_size = 2

      ami_type = "AL2_x86_64" # Amazon Linux 2
    }
  }

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
