1. What are the EC2 Instance types & Families?
2. What are the bustable instances -. t2 and 3 & t3a.
3. Types of Storage in AWS?
   Block Storage - EBS => FMT, FS, MOunt
   Object Storage - S3
   File Storage - EFS & FSx

   EBS => SSD[gp2,gp3,io1,io2] & HDD
3. EBS IO1 and IO2 for Cluster using Multi EBS Attachment.
4. EBS Volume cannot span between AZ.
5. If I deploy a MS SQL Multi Node Cluster using IO1 or IO2 Disks, 
   how can I make sure both the nodes dont endup in the same physical host?
   Answer: Using EC2 Placement Groups, and use Spread instead of Cluster & Partition.
https://aws.amazon.com/blogs/modernizing-with-aws/how-to-deploy-a-sql-server-failover-cluster-with-amazon-ebs-multi-attach-on-windows-server/

6. How to reduce a EBS Volume? 
   Stop application, Create a smaller volume and attach to machine. Move the data and repalce the
   mount points to the new volume and delete the old one.
7. How to move EBS volume between Regions and AZ?
   Between Region: Create volume snapshot in source and copy snaphot to other region and create volume.
   Between Az: Create volume snapshot and create volume from snapshot and while creating select diff AZ.

8. We can modify size and types of EBS Volume.

9. When AMI is created, it will create even named as CreateImage in CloudTrail.
   CloudTrail will track all API Activity in AWS Account. Intially data retained for 7 days and now its 90 days.
   Create Trail and select S3 bucket for long term retetion for more than 90 days.

10. To Capture the Events in AWS Cloud, we can use the service EventBridge.
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 AMI State Change"],
  "detail": {
    "State": ["available"]
  }
}
11. Based on the events like CreateImage event we can trigger Lambda Function to copy AMI to other regions.
12. There is no option to delete the AMI only Deregister and delete snapshot.
13. Its always recomanded to have a schedule for snapshots and multiple days of snapshots to restore data.
14. Packer custom AMI.
15. Why you need custom AMI?
    - Default AMI given by AWS dont have:
      - Monitoring Client like Cloudwatch or NodeExporter.
      - Log Collection Tools like LogStash or Filebeat etc
      - Secure Issues and vulnerabilities so we scan for CIS Bench marking for Level 1 and Level 2.
      - You application Dependencies Like Python or JDK etc etc.
16. OnDemand(Lifecycle=normal), Spot-instances(Lifecycle=Spot), Reserve Instance.
17. Spotinstance will be terminated or stopped with 2 min. Spot must not be used with Databases.


18. What are lifecycle hooks in autoscaling groups?
