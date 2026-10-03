terraform {
  required_providers {
    kind = {
      source  = "elioseverojunior/kind"
      version = "0.0.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

provider "kind" {}

resource "kind_cluster" "devops" {
  name           = var.cluster_name
  node_image     = "kindest/node:v1.30.2"
  wait_for_ready = 300

  node {
    role = "control-plane"

    extra_port_mappings {
      container_port = 80
      host_port       = 80
    }
    extra_port_mappings {
      container_port = 443
      host_port       = 443
    }
  }

  dynamic "node" {
    for_each = range(var.node_count)
    content {
      role = "worker"
    }
  }
}

resource "null_resource" "apply_resource_limits" {
  depends_on = [kind_cluster.devops]

  provisioner "local-exec" {
    command = <<-EOT
      for container in $(docker ps --filter "label=io.x-k8s.kind.cluster=${var.cluster_name}" --format "{{.Names}}"); do
        docker update --cpus="${var.cpu}" --memory="${var.memory}g" --memory-swap="${var.memory}g" "$container"
      done
    EOT
  }
}

output "cluster_name" {
  value = kind_cluster.devops.name
}

output "kubeconfig_path" {
  value = kind_cluster.devops.kubeconfig_path
}
