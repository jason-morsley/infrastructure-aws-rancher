#!/usr/bin/env bash

#    _____           _        _ _   _____                  _               
#   |_   _|         | |      | | | |  __ \                | |              
#     | |  _ __  ___| |_ __ _| | | | |__) |__ _ _ __   ___| |__   ___ _ __ 
#     | | | '_ \/ __| __/ _` | | | |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#    _| |_| | | \__ \ || (_| | | | | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_____|_| |_|___/\__\__,_|_|_| |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   
#
                                                                                
# Install Rancher via Helm
        
echo "===========================================================> INSTALLING RANCHER"
      
if [[ -z "${FOLDER}" ]]; then   
    echo "No FOLDER supplied."
    exit 666
fi
echo "FOLDER:" ${FOLDER}

if [[ -z "${NAMESPACE}" ]]; then   
    echo "No NAMESPACE supplied."
    exit 666
fi
echo "NAMESPACE:" ${NAMESPACE}

if [[ -z "${HOSTNAME}" ]]; then   
    echo "No HOSTNAME supplied."
    exit 666
fi
echo "HOSTNAME: " ${HOSTNAME}
                                               
export KUBECONFIG=${FOLDER}/kube-config.yaml

#chmod 400 $(pwd)/rancher/node.pem

# https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/

# Cert-Manager...

#kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.15.0/deploy/manifests/00-crds.yaml
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.15.0/cert-manager.crds.yaml

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm install cert-manager jetstack/cert-manager \
  --version v0.15.0 \
  --namespace cert-manager \
  --wait

kubectl get all --namespace cert-manager
  
# Rancher...

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

helm repo update

#kubectl create namespace ${NAMESPACE}
kubectl create namespace cattle-system

# Let's Encrypt --> Production
#helm install rancher rancher-stable/rancher \
#  --namespace cattle-system \
#  --set hostname=rancher.jasonmorsley.io \
#  --set ingress.tls.source=letsEncrypt \
#  --set letsEncrypt.email=letsencrypt@morsley.uk

# Let's Encrypt --> Staging


helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --version v2.4.2 \
  --set hostname=rancher.jasonmorsley.io \
  --wait

kubectl -n cattle-system rollout status deploy/rancher

#  --namespace ${NAMESPACE} \
#  --set hostname=${HOSTNAME} \
#  --wait
#  --version v2.4.2 \
#  --set ingress.tls.source=rancher \
#  --set letsEncrypt.email=letsencrypt@morsley.uk \
#  --set letsEncrypt.environment=staging \
#  --set auditLog.level=3 \
#  --set addLocal=true \
#  --wait
#  --set ingress.tls.source=letsEncrypt \

# https://whynopadlock.com
# https://www.ssllabs.com/ssltest/

# https://rancher.com/docs/rancher/v2.x/en/installation/options/troubleshooting/

echo "<============================================================ RANCHER INSTALLED"

exit 0