AWS CF is Content Delivery Network(CDN).
1. To speed up the website by using Caching.
2. Cloudflare & Fastly & Akamai providing the CDN.

3. I want to host website very cheaper but I must have
- SSL/TLS Secure connections
- Custom doman names.
- WAF Integration.
- Mostly imp it should be cheaper.

I have data in S3 Bucket which I want to share to all but dont want to
give public access on the S3 bucket.

We can allow only access from CF to S3 Bucket using Origin Access Control (OAC) Policy.