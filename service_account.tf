data "aws_iam_policy_document" "assume-policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider}:sub"

      values = [
        "system:serviceaccount:*:*"
      ]
    }

    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }
  }
}

resource "aws_iam_role" "eks-admin" {
  name                = "eks-admin"
  path                = "/eks-cluster/"
  assume_role_policy  = data.aws_iam_policy_document.assume-policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "kubernetes_service_account" "core_dns_fixer" {
  metadata {
    name      = "core-dns-fixer"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks-admin.arn
    }
  }
}

resource "kubernetes_role" "core_dns_fixer" {
  metadata {
    name      = "core-dns-fixer"
    namespace = "kube-system"
  }

  rule {
    api_groups     = ["apps"]
    resources      = ["deployments"]
    resource_names = ["coredns"]
    verbs          = ["get", "patch"]
  }
}

resource "kubernetes_role_binding" "core_dns_fixer" {
  metadata {
    name      = "core-dns-fixer"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.core_dns_fixer.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.core_dns_fixer.metadata[0].name
    namespace = "kube-system"
  }
}