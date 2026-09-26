# Cluster Kubernetes local com Kind via Terraform

## Sobre o projeto
Este projeto provisiona um cluster Kubernetes local usando o Kind (Kubernetes in Docker),
inteiramente através de código Terraform, sem nenhum comando manual de `kind create cluster`.

## Topologia
- **Nome do cluster:** devops
- **1 node control-plane** (`devops-control-plane`)
- **2 nodes workers** (`devops-worker`, `devops-worker2`)

## Como foi provisionado
O Terraform usa o provider `elioseverojunior/kind`, que expõe um recurso `kind_cluster`.
A quantidade de workers é controlada pela variável `node_count`, definida em `variables.tf`,
e o `main.tf` usa um bloco `dynamic "node"` para criar automaticamente um node worker para
cada unidade dessa variável.

## Componentes provisionados pelo Kind

- **kube-apiserver** — porta de entrada do cluster: todo comando `kubectl` fala com ele.
- **etcd** — banco de dados que guarda todo o estado do cluster. Roda no control-plane.
- **kube-scheduler** — decide em qual node cada novo pod deve rodar.
- **kube-controller-manager** — mantém o estado desejado do cluster (ex: número de réplicas).
- **kubelet** — roda em cada node, garante que os containers dos pods estejam de pé ali.
- **kube-proxy** — cuida do roteamento de rede entre pods e serviços.
- **CoreDNS** — DNS interno do cluster, resolve nomes de serviços para IPs.
- **kindnet** — plugin de rede (CNI) que permite comunicação entre pods de nodes diferentes.
- **local-path-provisioner** — provisiona armazenamento persistente local para Pods.

## Como validar

\`\`\`bash
kind export kubeconfig --name devops
kubectl get nodes -o wide
kubectl cluster-info
\`\`\`

## Evidências
Ver pasta `/prints` com capturas de tela do `kubectl get nodes -o wide`, `kubectl cluster-info`
e da visualização do cluster no Lens.


# teste social de conflito de brench
# testeetete
# pra acabar com
# mundando o arquivo 