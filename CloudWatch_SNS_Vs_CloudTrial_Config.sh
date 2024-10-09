AWS Cloudwatch => AWS Native Monitoring Service.
- Dashboards
- Alarms
- LogGroups

1. I want to monitor Memory & Diskspace of EC2 Instance?
   Install CloudWatch Agent and configure it.
   We can save Cloudwatch Agant Config in ParamterStor.
   We can install CW agent using Ansible or UserData bootstrapping.
   Its also recomanded install CW agent and convert that in to AMI.
# install CW-agent
echo "starting CW agent"
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb -P /tmp/
cd /tmp
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c default
echo "checking CW agent status"
sudo systemctl status amazon-cloudwatch-agent
sudo systemctl stop amazon-cloudwatch-agent
echo "done ubuntu"

We can combine multiple alarms using Composite Alarms with AND or OR option.

AWS Simple Notification Service(SNS) for sending notifications in case of Alerts/Alarms.
- Notify using Email.
- Notify using WebHooks with PagerDuty
  https://events.pagerduty.com/integration/14b6e050f70f4407d03dd420e4fd6a8f/enqueue  
- Notify using SMS
- Trigger Lambda

##  AWS Cloudwatch vs AWS Cloudtrail vs AWS Config

AWS Cloudtrail - Continuously log your AWS account API activity with Console or App like Terraform or CLI/CDK
Default Logs Duration is 90 days and more than that we need to configure Trail to S3 Bucket for longterm.

AWS Config - 
1. Allows to record the changes happening on the selected resources like tag rename, ip change etc etc.
2. Allows to create rules for compliance.









