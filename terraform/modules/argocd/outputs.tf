output "argocd_url" {
  value       = kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname
  description = "Public URL of ArgoCD Server"
}