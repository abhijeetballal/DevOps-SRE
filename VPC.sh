1. What is your 3 tier application? How you created network Design?
Ans: It’s a public (directly connected to internet) and private subnets. All the servers (web-server, app-server, and database-server) will be deployed in private subnet. 
Deploy ALB (ssl termination, Https redirection, path-based routing) in public subnet. Traffic will come through Route53 and hit ALB. 
From ALB that traffic sends to backend servers that’s to web server.

2. There are 2 types of traffic:
i. Application traffic.
ii. Management Traffic.

Management Traffic - If private server wants to update some packages, it will use NAT Gateway to send the traffic outside thru Internet Gateway for the updates, that traffic is called Management Traffic.

3. Endpoints - My private server wants to access to S3 bucket in order to upload and download the data.
a. There are 2 types of Endpoints:
i. Interface Endpoints - is basically Elastic Network Interface which content private IP. 
ii. Gateway Endpoints - is mostly used by S3 and DynamoDB which content route table entry.
b. S3 and DynamoDB use both Interface and Gateway Endpoint.

VPC Peering: If you want establish connection between 2 or 3 VPC’s, then VPC peering is good option. Because VPC peering is free of cost no additional charges will apply. If you want establish connection between 7 or 8 VPC’s then it will be hard with VPC peering because we have to add a lot of routing to it.
To overcome above issue – Transit Gateway is the better solution.
Transit Gateway: In transit gateway you just need a single connection between the VPC’s.
Hence transit gateway is the better option for this.


4. What are the difference between NACL and Security Group?
Ans: NACL provides security at subnet level and it is stateless. Since it is stateless, you need to allow both the traffic inbound and outbound. Security Group provides the security at instance level and it is statefull. In security Group If you allowed inbound traffic then there is no need to allow response traffic.

Transit Gateway: By using transit gateway you can also allow other AWS account to talk with your VPC’s as well.

Elastic IP:  Elastic IP are static IP

5. Why you need Elastic IP for NAT Gateway?
Ans: If your private server want to reach external API like bank servers or something else and that Admin said share the IP, so that I can allow that IP in our server. Hence for this purpose NAT gateway needs Elastic IP.

6. What is a main Routing table?
Ans: Because every time you create subnet by default it will create the routing table. It is called main routing table. You cannot delete main routing table.



