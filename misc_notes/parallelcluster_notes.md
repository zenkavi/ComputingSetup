## Make key pair for `test-cluster`

```
export KEYS_PATH=/Users/zenkavi/aws_keys

aws ec2 create-key-pair --key-name test-cluster --query 'KeyMaterial' --output text > $KEYS_PATH/test-cluster.pem

chmod 400 $KEYS_PATH/test-cluster.pem

aws ec2 describe-key-pairs
```

## Create cluster config using `make_test_cluster_config.sh`

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
