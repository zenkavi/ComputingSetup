## Make key pair for `test-cluster`

```
export KEYS_PATH=/Users/zenkavi/aws_keys

aws ec2 create-key-pair --key-name test-cluster --query 'KeyMaterial' --output text > $KEYS_PATH/test-cluster.pem

chmod 400 $KEYS_PATH/test-cluster.pem

aws ec2 describe-key-pairs
```

## Create cluster config using `make_test_cluster_config.sh`

Note: The AMI name `alinux2` reached its end of life but suppoer for AmazonLinux 2023 has not been implemented yet https://github.com/aws/aws-parallelcluster/issues/5214

```
sh make_test_cluster_config.sh
```

## Create cluster using the config

```
pcluster create-cluster --cluster-name test-cluster --cluster-configuration tmp.yaml

pcluster list-clusters
```

## Connect to cluster

```
export KEYS_PATH=/Users/zenkavi/aws_keys

pcluster ssh --cluster-name test-cluster -i $KEYS_PATH/test-cluster.pem
```

## Delete cluster

```
pcluster delete-cluster --cluster-name test-cluster
pcluster list-clusters
```
