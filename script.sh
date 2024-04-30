#Install k3s 
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_OUTPUT="/root/.kube/config" sh

#Install argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#Install argocd-rollout
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

#Export argocd
kubectl patch svc argocd-server -n argocd --type merge -p '{"spec": {"type": "LoadBalancer", "ports": [{"port": 8080, "name": "http", "targetPort": 8080},{"port": 8443, "name": "https", "targetPort": 8080}]}}'

#Create apps
kubectl apply -f https://raw.githubusercontent.com/ricardotjr/poc/main/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/ricardotjr/poc/main/app-example.yaml
kubectl apply -f https://raw.githubusercontent.com/ricardotjr/poc/main/locust.yaml