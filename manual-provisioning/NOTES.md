# Notes on manual cluster provisioning
### Nginx ingress controller
* helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
* helm repo update ingress-nginx
* kubectl create ns ingress-nginx
* helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --values configs/ingress-nginx/values.yaml --namespace ingress-nginx --create-namespace
##### Documentation
* https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
### Metrics server
* kubectl apply -f configs/metrics-server/components.yaml
* kubectl top nodes
##### Documentation
* https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
### Cluster Autoscaler
* helm repo add autoscaler https://kubernetes.github.io/autoscaler
* helm upgrade --install cluster-autoscaler --namespace kube-system autoscaler/cluster-autoscaler --values configs/cluster-autoscaler/values.yaml
##### Documentation
* https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler
### EFS CSI Driver
* helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
* helm repo update aws-efs-csi-driver
* helm upgrade --install aws-efs-csi-driver --namespace kube-system aws-efs-csi-driver/aws-efs-csi-driver --values configs/efs-csi-driver/values.yaml
* kubectl apply -f configs/efs-csi-driver/efs-sc.yml
##### Documentation
* https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master#readme
### EBS CSI Driver
* helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver/
* helm repo update aws-ebs-csi-driver
* helm upgrade --install aws-ebs-csi-driver --namespace kube-system aws-ebs-csi-driver/aws-ebs-csi-driver --values configs/ebs-csi-driver/values.yaml
* kubectl apply -f configs/ebs-csi-driver/ebs-sc.yaml
##### Documentation
* https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/install.md
### CloudWatch Agent
* aws eks create-addon --cluster-name demo-dev01 --addon-name amazon-cloudwatch-observability --resolve-conflicts OVERWRITE
* aws eks delete-addon --cluster-name demo-dev01 --addon-name amazon-cloudwatch-observability
##### Documentation
* https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-addon.html
