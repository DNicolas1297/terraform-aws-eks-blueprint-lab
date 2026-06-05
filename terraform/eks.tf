module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "sandbox-cluster"
  cluster_version = "1.30"

  # Tu lógica: El plano de control se conecta a la red global, pero..
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # ¡Los nodos vivirán aquí!

  # Tu lógica de seguridad: Endpoint accesible pero ultra restringido
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["186.86.110.77/32"]
  cluster_endpoint_private_access      = true

  # Configuración simplificada para nodos administrados (Managed Node Groups)
  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 2

      instance_types = ["t3.medium"] # Económico para pruebas
      subnet_ids     = module.vpc.private_subnets
    }
  }

  tags = {
    Environment = "sandbox"
    Project     = "fullstack-blueprint"
  }
}
