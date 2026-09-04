variable "cluster_name" {
  description = "Nome do cluster kind"
  type        = string
  default     = "devops"
}

variable "node_count" {
  description = "Quantidade de worker nodes do cluster (além do control-plane)"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "Quantidade de vCPUs alocadas por node"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memória em GB alocada por node"
  type        = number
  default     = 2
}
