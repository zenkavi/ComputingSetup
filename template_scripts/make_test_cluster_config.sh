#! /bin/zsh
# alias aws='docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli:2.11.26'
export REGION=`aws configure get region`
export SUBNET_ID=`aws ec2 describe-subnets | jq -j '.Subnets[0].SubnetId'`
export VPC_ID=`aws ec2 describe-vpcs | jq -j '.Vpcs[0].VpcId'`

cat > tmp.yaml << EOF
Region: ${REGION}
Image:
  Os: alinux2
SharedStorage:
  - MountDir: /shared
    Name: default-ebs
    StorageType: Ebs
HeadNode:
  InstanceType: t3.micro
  Networking:
    SubnetId: ${SUBNET_ID}
    ElasticIp: false
  Ssh:
    KeyName: test-cluster
  Iam:
    S3Access:
      - BucketName: zenkavi
        EnableWriteAccess: True
    AdditionalIamPolicies:
      - Policy: arn:aws:iam::aws:policy/AmazonS3FullAccess
Scheduling:
  Scheduler: slurm
  SlurmQueues:
    - Name: compute
      CapacityType: ONDEMAND
      ComputeResources:
        - Name: compute
          InstanceType: c5.large
          MinCount: 0
          MaxCount: 2
          DisableSimultaneousMultithreading: true
      Networking:
        SubnetIds:
          - ${SUBNET_ID}
        PlacementGroup:
          Enabled: true
      Iam:
        S3Access:
          - BucketName: zenkavi
            EnableWriteAccess: True
        AdditionalIamPolicies:
          - Policy: arn:aws:iam::aws:policy/AmazonS3FullAccess
EOF