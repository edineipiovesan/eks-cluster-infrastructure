resource "time_sleep" "wait_30_seconds" {
  depends_on = [
    module.eks.fargate_profiles
  ]

  create_duration = "30s"
}

resource "kubernetes_job" "patch_core_dns" {
  depends_on = [
    time_sleep.wait_30_seconds,
    kubernetes_service_account.core_dns_fixer,
    kubernetes_role_binding.core_dns_fixer
  ]

  metadata {
    name      = "patch-core-dns"
    namespace = "kube-system"
  }

  spec {
    ttl_seconds_after_finished = 0
    template {
      metadata {}
      spec {
        service_account_name = kubernetes_service_account.core_dns_fixer.metadata[0].name
        container {
          name    = "patch-core-dns"
          image   = "bitnami/kubectl:latest"
          command = ["/bin/sh", "-c", "kubectl patch deployments.app/coredns -n kube-system --type json -p='[{\"op\": \"remove\", \"path\": \"/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type\"}]'"]
        }
        restart_policy = "Never"
      }
    }
  }

  wait_for_completion = true

  timeouts {
    create = "5m"
  }
}

resource "kubernetes_job" "restart_core_dns" {
  depends_on = [
    kubernetes_job.patch_core_dns
  ]

  metadata {
    name      = "restart-core-dns"
    namespace = "kube-system"
  }

  spec {
    ttl_seconds_after_finished = 0
    template {
      metadata {}
      spec {
        service_account_name = kubernetes_service_account.core_dns_fixer.metadata[0].name
        container {
          name    = "restart-core-dns"
          image   = "bitnami/kubectl:latest"
          command = ["/bin/sh", "-c", "kubectl rollout restart deployments.app/coredns -n kube-system"]
        }
        restart_policy = "Never"
      }
    }
  }

  wait_for_completion = true

  timeouts {
    create = "5m"
  }
}