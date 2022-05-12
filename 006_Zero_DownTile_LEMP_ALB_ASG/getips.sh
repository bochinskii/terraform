#!/usr/bin/sh
#
#
#
ASG="my_lemp_asg"
REGION="eu-central-1"
IPS=""
IDS=""
while [ "$IDS" = "" ]; do
  ids=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG --region $REGION --query AutoScalingGroups[].Instances[].InstanceId --output text`
  sleep 1s
done
for ID in $IDS;
do
    IP=`aws ec2 describe-instances --instance-ids $ID --region $REGION --query Reservations[].Instances[].PublicIpAddress --output text`
    ips="$IPS,$IP"
done