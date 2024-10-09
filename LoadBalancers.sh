1. What are types of Load Balancers in AWS?
Regional/VPC & Global Load Balancers.

Regional/VPC :
1. Network LB - Layer 4 [Trasport] - TCP or UDP.
2. Application LB - layer 7 [Application] - HTTP/HTTPS Based applications.
   a. http to https redirection
   b. url/path based routing
   c. blue-green & canary based routing
   4. WAF Integration

3. Classic LB
4. Gateway LB.

Global LB:
1. Route53 Routing Policies:
   - Its DNS Based load balancer. We cannot select Protocol or Port number.
     No static public exists.

2. Global Accelerator - Opton to select tcp/udp and also port 80,443.
   It will provide two Static IP Adress.
    77.5.6.78
    34.56.4.34

2. Explain how your appliction traffic flow or how customers are reaching you application
   from internet?