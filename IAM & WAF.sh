What Diff Between User vs Role vs Policy?
- IAM User is an identity used by Both Users & Application.
  Users can use AWS CLI or COnsile to access AWS.
  Apps like Terraform uses Access Keys for accessing AWS API.

 - IAM Role is used bu one aws service to access other. 
   Eg: Linux shutting Down EC2 Instances.
   Roles can also be assumed by users to manage other AWS Account.
   Eg: Terraform Assume Role to deploy in other AWS Accpounts.
       Admin uses switch role option to assume role and manage other account.

- IAM Policy is a JSON file where you defince permissions.

Diff types are IAM policies:
AWS Managed 
Customer Managed
Inline is also a IAM Policy is appied to Role or User or User Group which can be assigned
and will be deleted to that perticualr identity only. We cannot assign to multiple identities.

IAM Policy Hierarchy?
Default Deny -> Org Policies -> Resource Polcies -> Idenity Polcies -> Permission Boundries -> Session Policies

1. How can I manage multiple AWS Accounts.
Eg: I have 30 AWS Accounts. How to manage them?
Recomanded way is use Windows AD and AWS Identity Center for SSO.
Using AssumeRole option.

{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": [
      "arn:aws:iam::053490018989:role/Cross-Account-Role",
      "arn:aws:iam::053490018979:role/Cross-Account-Role"
    ]
  }
}

https://gist.github.com/noahcoad/370f004d3be248778dca41a1abc53543


1. How can I block all the users in all the accounts access to IAM and R53?
2. How can I block all the users block using IO1 and IO2 EBS in Dev and UAT?
3. How can I block all the users to deploy infra other than us-east-1 and us-east-2?

AWS Service Control Policies(SCP) is best practice for Compliance.

===============================================================================================



WAF
===============================================================================================

How to protect your web application? or What is WAF? or Where is WAF Applied?
How can I block certain IP to access my application?

SG, NACL and AWS Network Firewall. These cannot solve all problems.
1. I want to foce the user to use only Google Chrome or Edge or Firewall.
2. If I am getting more than 100 req in 5 min, I want to block it.
3. I want to block bots which are scanning my webapp.
4. I want to implement OWASP rules to proected from attacks?
5. How to enable CAPTHA on the URL?


Above problems can be resolved by AWS WAF.

AWS WAF Can be applied at two levels: 
At global level to Cloudfront CDN.
At regional level -> ALB, APIGW.

AWS WAF Container two fypes of rule grops:
- Managed Rule Groups
- Customer Own Rules and Rule Groups.

User Rules supports two types of Rules:
Regular rule - Block IP, Countru, Browser and it dont care about how many requests.
Rate-based rule - Block the IP if we get more than 100 Req in 5 min.

What is AWS Sheild?
Managed DDoS protection service.Standard and Advanced.
Standard is enabled at VPC level.