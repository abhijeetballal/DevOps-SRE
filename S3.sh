1. Is S3 a global service -> NO.
2. S3 is also called a Object Storage. No filesystem to mount.
3. S3 can be mounted as file system.
   - Old applicationc called as S3FS. - https://github.com/s3fs-fuse/s3fs-fuse
   - New Way is using s3mount - https://aws.amazon.com/blogs/aws/mountpoint-for-amazon-s3-generally-available-and-ready-for-production-workloads/
   The bucket must not have "." to mount, means www.hello.com is not a validname.
   www-helll-com is a valid.

4. What ara diff types of S3 Storage Classes?
   - Standard
   - Standard-IA
   - One-Zone
   - Intelligent-Tiering

5. I want my data saved for long term. What are my option?
   - If you access data requesntly, better to use S3 then glacier.
   - Glacier is a good solution for longteam and no frequest access bcoz
     restoring data using Glacier is a costly affair.

6. What are Lifecycle Policy?
   If you want to move the data across multiple tier based on the age of the files
   then Lifecycle polcieis are good.

CloudTrail saves API Access information for 90 days and if you need more 
retention we need to configure CloudTrail to S3 Bucket and configure lifecycle policies.

7. What is versioning in S3?
   I have deleted the some files accedently from S3. How to restore them?
   Use bucket versionsing.

8. Access files from S3 bucket without any public bucket policy.
   How can I provide temprary access to S3 files?
   What is a PreSigned URL and what are the uses?
   Ans: Use Presigned URLs
   https://devsecopskmsvault.s3.us-east-1.amazonaws.com/app.py?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEF0aCXVzLWVhc3QtMSJGMEQCIDXqSraNqQIRFDNg4Wn%2BvY%2FJV%2B1HxEKPdfxJFaTS2bW%2BAiBLIcXqZxKDtC%2F4mMGn%2F7MH%2F4cO9qwVYnCYiokt%2BgYucSrxAgiG%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAMaDDcyMTgzNDE1NjkwOCIMEh7TEXVOJB%2BMxCOGKsUCCDVZPOScS%2Fhwa3XbV8mnL%2BSNLSnV3CSriyAXa8TLv1modFWrt3fWNzQPg7YWppWOLWmadW0LfSgQh3Q%2B%2Fi1K9Umdu1y5DQXfzSYrAQZ%2FTYCK4dAwnBivWk4i9vloSuxDXd%2BGvXXFPQ2EYwcVkR7I8MjaBvobvFDXGcE%2BhfcOiSa%2F3FDXM766lgoOQQ3VJO9VKO9FMk%2FoG6AIuZXenK6%2B8z32YXHtZzt1tuEV6TCl0NqY7cyFgA0TwumTz%2Bo0vigquLZ5ELKGz5x7U2b3aYyJfuWbLQX4tp7smdXvQtq1QPcLswzXlD6YaU46C49Lo5Uhg40Nc9DulIGnt1siUSZTvsrxUwnIL5pOgiul9AzWx4kH6ZwwtPh7R3zFOh8OTgchzQ6QqcgsCYxr3G4WAZ4GjCesv7aigTa9MbZJcCBbv%2Fr9w72KATCrkoS3Bjq0AmS%2Fvz%2BAXDfUc%2B2MqsPPIqWc6nRGfB6PuQdiveZplEpGse4UVpaRugt6%2FKwhrgAR0XXFWNVIx0RNyNBvjr6pyVoMOvc8bZYZvEkDfP%2BiGNX9%2FV0yGZQUekbl0tB9AOYo5%2BHjaKDyGBFn8u3BNvlkyFQrgnOAXLdE6g0Fc1SaTCrOkKcKJSs4b4sZ9xTjEfnMRlu5vBDnvH7qpn6ntLfVBCGeykPeaxeJRLRL%2BLbyjqWeeUURvLDVhvGhT8j0ECunFcnkT4A%2BGHvrlyE%2BQvnUax9Rk%2BfODQaEewWzm7S8X3s5%2FsZzDNb9s4ho%2FVXK9pkl8qLNMy%2FB2IcvhlbfplWSxC6MKzq6rvg5CUNlpYHRVq6Og8IEWSOp3e%2FYWsyFkcrOMFi6HO33lQNk4eiOzxfjR9UARWdM&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240911T045639Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIA2QEFLENWIQX66ZHK%2F20240911%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=20bd7a92a9302036340b7e9e4c69ad9849a07f54c03cdedd53416cfeb7d3ecd0

9. I have a User in Account A and Need to upload & Downlaod files from S3 Bucket in 
   Account B. How to do it? How to provide crossaccount bucket access?
   1. In Account A, the user or role must have S3 Access.
   2. In Account B, open/create the bucket policy with get and put permissions
      in principal make sure you have given the USER/ROLE ARN of Account A.
      {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal": {
                "User": "arn:aws:iam::721834156908:user/s3admin",
                "Role": "arn:aws:iam::721834156908:role/admin_role_office"
            },
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::www.awsb62.xyz",
                "arn:aws:s3:::www.awsb62.xyz/*"
            ],
            "Effect": "Allow"
        }
    ]
}

10. How to host a website in S3 and make sure it dont have public Access 
    but everyone should be able to access website with https?

    Internet => Route53 => CloudFrontCDN(tls) => S3 Static Website.
    If we need restrict access to S3 from CF Only then we need to use 
    Amazon CloudFront Origin Access Control (OAC)
    CloudFront also provides https redirection.
    CloudFront is a global service similar to Route53.


11. We use S3 for storing logs from CloudTrain and LB.
    Its also used for uploding application data or artifacts as part of build.

12. Restrict S3 access to certain IP ranges. Thi is possible using Bucket Policy.
13. Using bucket policy we can restrict access to folders based on IPV4,6, VPCe, 
    Tags with usernames. 

14. Server-side encryption with Amazon S3 managed keys (SSE-S3) - Default
    Server-side encryption with AWS Key Management Service keys (SSE-KMS)








