# Setting Up EC2 Instance for AWS

## Setting up Kubernetes Cluster on AWS using KOPS

### Prerequisites

Before setting up the cluster ensure that the EC2 instance has the following permissions with IAM Roles:

```
AmazonEC2FullAccess
AmazonRoute53FullAccess
AmazonS3FullAccess
IAMFullAccess
AmazonVPCFullAccess
AmazonSQSFullAccess
AmazonEventBridgeFullAccess
```

This can be done using the AWS CLI or via the AWS Cloud Console.

### Install KOPS and Kubernetes

Use the following command to install KOPS (version 1.23.4)

```sh
$ curl -LO https://github.com/kubernetes/kops/releases/download/release-1.23/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
```

And the following command to install kubectl (version 1.23.4)

```sh
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/release-1.23/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

\*Note: Installing matching kubectl and kops version is required for proper function of the cluster.

Create an S3 Bucket to store the cluster persist cluster state information. Make the bucket public or configure private connection access between the EC2 instance and the S3 bucket.

Next, create a Route53 hosted zone for the EC2 instance, and set its VPC to the same as the EC2 instance. Choose a domain name.

### Generate a key to ssh into cluster

```sh
$ ssh-keygen
```

### Create Environment Variables

```sh
$ echo "export KOPS_CLUSTER_NAME={insert route53 dns}" > ~/.bashrc
$ echo "export KOPS_STATE_STORE=s3://{insert s3 bucket name}" > ~/.bashrc
$ source ~/.bashrc
```

### Create Cluster

Run the following code to create a schema of the cluster

```sh
$ kops create cluster \
--state=${KOPS_STATE_STORE} \
--node-count=2 \
--master-size=t2.medium \
--node-size=t2.micro \
--zones=us-east-2a,us-east-2b \
--name=${KOPS_CLUSTER_NAME} \
--dns private \
--master-count 1
```

\*Note: t2.micro which is part of aws free tier does not have sufficient cpu and memory for building the cluster. Attempting to build cluster on t2.micro master will result in failure to build and cause a loop of fail and rollbacks. Using t2.micro for nodes will limit the compute power for each node and consequently decrease the ability of weaviate, this will restrict our ability to use larger vectorizer models such as transformer text2vec.

Run the following to deploy the cluster

```sh
$ kops update cluster --yes
```

\*Notes: This process will take a while. After the instances are made, they will take even longer to connect to the DNS. If it fails, consult KOPS documentation or github issues section.

When finished, run the following command to confirm the cluster status

```sh
$ kops validate cluster
```

\*Notes, you may add a --wait 10 m, for the command to wait 10 minutes before validation.

### Confirm Status on Kubectl

Using kubectl, view nodes, view pods, and debug any issues as necessary.

```sh
$ kubectl get nodes
$ kubectl describe nodes
$ kubectl get pods
$ kubectl describe pods
```

\*Notes: If any of the following fails, consult the kubernetes issues section. One potential cause is dirty nodes fail to deploy.

### Delete Cluster

To delete cluster, run the following command

```sh
$ kops delete cluster  --yes
```

### Configuration Notes:

Kubectl versions beyond 1.24 do not work due to a DNS mapping issue which prevented the cluster from forming

## Setting up Weaviate Pods for Kubernetes Cluster on AWS

### Install Helm

```sh
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### Check Helm version (weaviate requires Helmv3 or higher)

```sh
$ helm version
```

### Add weaviate Helm Repo

```sh
$ helm repo add weaviate https://weaviate.github.io/weaviate-helm
```

### Get default values.yaml

```sh
$ helm show values weaviate/weaviate > values.yaml
# Edit values (Optional)
$ vi values.yaml
```

\*Notes: By default the vectorizer modules of weaviate helm are turned off, meaning that users will need to provide their own vectors when populating the database. However, users can activate modules such as text2vec-contextionary or text2vec-transformers by setting their value to true in values.yaml. Security, visibility, authentication, authorization configurations are also made here. RecipeCart currently can only run text2vec-contextionary due to using t2.micro node instances. However for production t2.medium nodes should be used to enable text2vec-transformers or text2vec-gpt4all.

### EFS permissions for persistent volume

Weaviate uses EFS for persistent storage of its data. To set it up, simply add the IAM for EFS to the EC2 role. If that does not work, view the weaviate pod and describe. Then view kubernetes pv (persistent volumes) and kubernetes pvc (persistent volume claims), and delete/regenerate them as neccessary.

### Deploy

Create a namespace for weaviate

```sh
$ kubectl create namespace weaviate
```

Deploy weaviate using helm with values from values.yaml

```sh
helm upgrade --install \
  "weaviate" \
  weaviate/weaviate \
  --namespace "weaviate" \
  --values ./values.yaml
```

### Debug

Using kubectl, view nodes, view pods, and debug any issues as necessary.

```sh
$ kubectl get nodes -n weaviate
$ kubectl describe nodes -n weaviate
$ kubectl get pods -n weaviate
$ kubectl describe pods -n weaviate
$ kubectl get pv -n weaviate
$ kubectl describe pv -n weaviate
$ kubectl get pvc -n weaviate
$ kubectl describe pvc -n weaviate
$ kubectl get services -n weaviate
$ kubectl describe services -n weaviate
```

\*Notes: using get services, you can receive the address where the weaviate client can connect to using http protocol.

### Configuration Notes:

Weaviate requires kubectl version above 1.22, leaving only option 1.23 which is not a stable release.

##
