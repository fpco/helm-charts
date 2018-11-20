
Example `settings.yaml`:

```
enabled:
  kube-lego: true
  external-dns: true
  heapster: false
  kubernetes-dashboard: false
  kube2iam: true

kube-lego:
  config:
    # set your email
    LEGO_EMAIL: devops@MYCOMPANY.com
    LEGO_URL: https://acme-v01.api.letsencrypt.org/directory
  rbac:
    create: true

# We need kube2iam for assigning the correct role to the external-dns pod
# via the podAnnotations annotation
kube2iam:
  host:
    iptables: true
    interface: cni0
  rbac:
    create: true
  extraArgs:
    auto-discover-base-arn: true

external-dns:
  image:
    tag: v0.4.5
  podAnnotations:
    "iam.amazonaws.com/role": MY_IAM_ROLE
  rbac:
    create: true
```

`NOTE`: Use [this terraform module](https://registry.terraform.io/modules/fpco/foundation/aws/0.8.1/submodules/external-dns-iam)
for creating the externa-dns iam role.

Deploy by running helm:

```
helm --debug \
  upgrade \
  --install \
  fpco-foundation fpco/foundation \
  --version 0.3.0 \
  --values=settings.yaml \
  --namespace=kube-system
```
