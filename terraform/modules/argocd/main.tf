resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace
  version    = "5.51.6" # You can pin this to a stable version

  create_namespace = true

  values = [file("${path.module}/values.yaml")]

  depends_on = [
    kubernetes_namespace.argocd
  ]
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}
