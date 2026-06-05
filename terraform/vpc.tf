module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "fullstack-sandbox-vpc"
  cidr = "10.0.0.0/16" # Bloque grande para todo el complejo

  # Distribución en 3 Zonas de Disponibilidad para Alta Disponibilidad
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  # Subredes Públicas pequeñas (ej. 251 IPs utilizables por subnet)
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  # Subredes Privadas GRANDES para EKS y tus Pods (ej. ~1019 IPs por subnet)
  private_subnets = ["10.0.4.0/22", "10.0.8.0/22", "10.0.12.0/22"]

  enable_nat_gateway = true
  single_nat_gateway = true # Para ahorrar costos en tu ambiente sandbox

  # El secreto de K8s: Tags para que el ALB Controller descubra las subredes
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
