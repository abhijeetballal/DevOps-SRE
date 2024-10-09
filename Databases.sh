SQL vs NoSQL


1. Databases for Structured Data
   - AWS RDS -> MySQL, MSSQL, Oracle, AroraDB, Postgres, MariaDB, Db2
     The data will be in Cols and Rows and data must follows rules which we call it
     as schema.

   - For Data Warehousing it will be Redshift based on Postgres. 

Creates a primary DB instance and a standby DB instance in a different AZ. 
Provides high availability and data redundancy, 
but the standby DB instance doesn't support connections for read workloads.

Creates a DB cluster with a primary DB instance and two readable standby DB instances,
with each DB instance in a different Availability Zone (AZ).
Provides high availability, data redundancy and increases capacity to 
serve read workloads.

2. Databases for Unstructured Data
   - AWS DynamoDB - keyvalue pair based NoSQL - Serverless.
   - AWS DocumentDB - Managed MongoDB - Documents
   - AWS Cassandra

SQL -> Database -> Tables -> Cols -> Rows
NoSQL -> Database -> Collections -> Documents -> Feilds


AWS Aurora DB -> Postgres(Handle huge amount of data then PG is good.)

MySQL(Readindg and good fit for WebApps)

MySQL has an advantage over Postgres for extremely write-intensive workloads, 
while PostgreSQL is faster when handling massive datasets, 
complicated queries, and read-write operations

https://repost.aws/knowledge-center/aurora-mysql-cluster-backtrack

How DB Connectivity is configured in applications?
ConnectionStrings must be secure as it contains sesitive data.
- Using AWS SSM Parameter Store.

 import boto3
    ssm_client = boto3.client('ssm')
    ssm_client.get_parameter(Name="AccessKey", WithDecryption=True)

    {u'Parameter': {u'Name': u'AccessKey', u'DataType': u'text', u'LastModifiedDate': datetime.datetime(2022, 7, 16, 13, 25, 47, 636000, tzinfo=tzlocal()), u'Value': u'123456789', u'Version': 1, u'Type': u'SecureString', u'ARN': u'arn:aws:ssm:us-east-2:accountID:parameter/AccessKey'}, 'ResponseMetadata': {'RetryAttempts': 0, 'HTTPStatusCode': 200, 'RequestId': '04127def-460e-4eca-a3b0-d3e43d03a3c5', 'HTTPHeaders': {'x-amzn-requestid': '04127def-460e-4eca-a3b0-d3e43d03a3c5', 'content-length': '205', 'server': 'Server', 'connection': 'keep-alive', 'date': 'Sat, 16 Jul 2022 10:30:42 GMT', 'content-type': 'application/x-amz-json-1.1'}}}

- Using SecretManager

Advatnages of secrets manager:
1. Secret Rotation
2. Secret Generation
3. Cross account access.

Disadvantage is its costly.

For backup and restore of databases:
1. AWS Backup.
2. Automatic snapshots.
3. Database Migration Service(DMS) for Schema Convertion and data movement
and also replicate ongoing changes.


Copy Database between regions:
1. Create a replica in diff region. Them promote replicate to read/write.
2. If replicas is not supported, then use DMS from one region to other.
3. Download the data and restore it manually in other region.


