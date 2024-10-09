1. What is CloudTrail?
CloudTrail provides visibility into user activity by recording actions taken on 
your account. CloudTrail records important information about each action, 
including who made the request, the services used, the actions performed, 
parameters for the actions, and the response elements returned by the AWS service.

In other words, it will record all the API Activity perfomed on Console, CLI, 
Apps like terraform. The even history will availible for 90 days (Ealier it as 7 days).
For more than 90 days we need to move Logs to S3 bucket cloud trail.


CreateImage Event ==> Captured By EventBridge ==> Trigger AWS Lambda.

In the Lambda Function, we will create the logic for copying the the AMI to diffrent regions.

AWS Lambda is there to execute your code.
Java, Python, PHP, .NET, Ruby, Nodejs

Challanges with Lambda:
1. The maximum time for running Lambda function is 900 Sec(15min) and ealier it as 300 secret.
2. Maximum Memory for a Lambda function is 10GB.
3. Maximum Ephemeral Storage for a Lambda function is 10GB.

Every lambda function must has a role which can given permissions to acess other resources.


What is AWS Lambda Coldstart? How do you improvde Lambda Performance? 
Cold starts in AWS Lambda occur when an AWS Lambda function is invoked after not being used for 
an extended period, or when AWS is scaling out function instances in response to increased load.

Major Impact Use Cases - This is Where It Hurts
https://www.ranthebuilder.cloud/post/is-aws-lambda-cold-start-still-an-issue-in-2024
https://aws.amazon.com/blogs/compute/operating-lambda-performance-optimization-part-1/


If you need predictable function start times for your workload, Provisioned Concurrency is the recommended 
solution to ensure the lowest possible latency. This feature keeps your functions initialized and warm, 
ready to respond in double-digit milliseconds at the scale you provision. Unlike on-demand Lambda functions,
this means that all setup activities happen ahead of invocation, including running the initialization code.

What is lambda_handler in Lambda Function?
The Lambda function handler is the method in your function code that processes events.
 When your function is invoked, Lambda runs the handler method.

What is event in Lambda?
Event is a paramter/argument. When Lambda is triggered by EventBridge because of a AMI Creation,
then the event container the AMI Information.

#EVENT:
{'version': '0', 
'id': 'c0eb33a9-e278-a924-0230-8348afc5fbf9', 
'detail-type': 'EC2 AMI State Change', 'source': 'aws.ec2', 'account': '721834156908', 
'time': '2024-09-05T04:55:48Z', 'region': 'us-east-1', 
'resources': ['arn:aws:ec2:us-east-1::image/ami-024700d6a8125671e'], 
'detail': {'RequestId': '1995a11e-f71f-403a-aea2-a9c30e8222cb', 
'State': 'available', 'ImageId': 'ami-024700d6a8125671e', 'ErrorMessage': ''}}

regions = ['us-east-2','ap-south-1']
def lambda_handler(event, context):
    print(event)
    print(event['detail']['ImageId'])
    amiid = event['detail']['ImageId']
    for reg in regions:
        client = boto3.client('ec2',region_name=reg)
        response = client.copy_image(
        Encrypted=False,
        Name='batch-63-ami',
        SourceImageId=amiid,
        SourceRegion='us-east-1'
        )

What are layers in Lambda?
A Lambda layer is a .zip file archive that contains supplementary code or data. 
Layers usually contain library dependencies, a custom runtime, or configuration files. 
There are multiple reasons why you might consider using layers: 
To reduce the size of your deployment packages.

How Lambda can reach external API's out side of AWS?
1. Deploy Lambda in VPC on private subnet and add internet routing though NAT Gateway.


Website(EC2 or S3 Static) ==> AWS API Gateway ==> SQS ==> Lambda (AppServer) ==> Database.

Serverless Architecture where frontend is writing to database from Lambda.

