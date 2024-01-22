
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

eksctl version





eksctl create cluster --node-type t3.medium --version 1.27 --nodes 3

eksctl get cluster




----------------------------------------

S3BUCKETNAME=loki-bucket-2345234524352435
AWSREGION=us-east-1

Create S3

aws s3api create-bucket --bucket $S3BUCKETNAME --region $AWSREGION

Install HELM
bash <(curl -fsSL  https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 --)

Install Loki repo
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

