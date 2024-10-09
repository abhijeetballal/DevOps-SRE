1. If I want to create 10 Virtual Machine how to do it?
A: Using Count Function. We  also have for-each to create multiple resources but count is the best way to create multiple resources.

resource "aws_security_group" "instance" {
  count = 10
  name = "instance-${count.index}"
  vpc_id = "vpc-123456"
}

2. What is the difference between count and for-each?
A: Count takes list as a input and follows index based approach. 
For-each takes map as a input and follows key-value pair approach and dont have index.
var.azs = ["us-east-1a", "us-east-1b", "us-east-1c","us-east-1d"] - works welll
               0          1            2            3
var.azs = ["us-east-1d", "us-east-1a", "us-east-1b", "us-east-1c"]
                0          1            2            3

count(list, index)
counnt(var.azs, count.index)

3. What are diff functions you have used in Terraform?
A: 
count(list, index)
element(list, index) - Its allows to select a single element from a list.
lookup(map, key, default) - Its allows to select a single element from a map.

{
  "us-east-1" = "ami-11111",
  "us-east-2" = "ami-22222"
}
lookup(var.ami, var.region, "ami-default")
length(list) - Its allows to get the length of the list.
count             = length(var.public_subnet_cidrs)

toset(list) - Its allows to convert list to set. Means it will remove duplicates and remove the order.
distinct(list) - Its allows to remove duplicates from the list but preserves the order.

ports = toset([80, 443, 22, 80, 443, 22]) => [80, 443, 22]
ports = distinct([80, 443, 22, 80, 443, 22]) => [80, 443, 22]
lower() and upper()
split(",", "follow,this,blog") => ["follow", "this", "blog"]
split(" ","Welcome To DevOps Training In Telugu") => ["Welcome", "To", "DevOps", "Training", "In", "Telugu"]
join(",", ["follow", "this", "blog"]) => "follow,this,blog"
join("-", ["Welcome", "To", "DevOps", "Training", "In", "Telugu"]) => "Welcome-To-DevOps-Training-In-Telugu"
4. What is Terraform Console?
A: Terraform Console is a command line tool that allows you to evaluate expressions in the context of a Terraform configuration.

5. How can I implement conditional logic of if condition in Terraform?
condition == true ? "true-value" : "false-value"
count = var.environment == "prod" || var.environment == "production" ? 3 : 1
count = var.environment == "prod" && var.account == "123456" ? 3 : 1

6. What is Dynamic Blocks in Terraform?
A: Dynamic blocks allow for more complex configuration of nested blocks. For-each is used along with dynamic blocks are used to create multiple blocks within a resource.
resource "aws_security_group" "sg_dynamic" {
  name        = "sg_dynamic"
  description = "Allow all inbound traffic using Dynamic Blocks"
  vpc_id      = aws_vpc.default.id
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
ingress_ports = ["22", "80", "443", "3389", "3306", "80", "443", "3389", "22", "80", "443", "3389", ]

7. How can protect resources from being destroyed? (or) What are lifecycle blocks in Terraform or How can force Terraform to create replacement and then destroy the old resource? or I want to make some changes to Tags but I dont want terraform to override the resource?

life_cycle {
  prevent_destroy = true,
  create_before_destroy = true,
  ignore_changes = ["tags","ingress","instance_type",key_name"]
}

8. Terraform taint and untaint.
A: Terraform taint is used to mark a resource for recreation. Terraform untaint is used to remove the taint from the resource.
terraform taint aws_instance.web => This will mark the resource for recreation and will be recreated in the next terraform apply.
terraform untaint aws_instance.web => This will remove the taint from the resource.

9. What are provisioners in Terraform?
- file provisioner to copy files from local to remote machine.
- remote-exec provisioner to execute commands on remote machine.
- local-exec provisioner to execute commands on local machine.
- chef provisioner to execute chef recipes on remote machine.
- puppet provisioner to execute puppet scripts on remote machine. Not Used much.
- ansible provisioner to execute ansible playbooks on remote machine. Not Used much.
- salt-masterless provisioner to execute salt scripts on remote machine. Not Used much.

10. What is a null_resource in Terraform?
Scenario: I have a script which changes every day 9PM. When this script is changed I want to copy to the remote machine and execute it. How can I do it?

This issue can be resolved using null_resource. Null_resource is a resource that does not do anything. It is used to run provisioners. It is used to run local-exec, remote-exec, file provisioners.

resource "null_resource" "script" {
  provisioner "file" {
    source = "${path.module}/script.sh"
    destination = "/tmp/script.sh"
    connection {
      type = "ssh"
      user
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${path.module}/script.sh",
      "chmod +x ${path.module}/script.sh",
      "sudo ${path.module}/script.sh"
    ]
    connection {
      type = "ssh"
      user
    }
  }
}

We can taint null_resource everydat at 9PM and execute terraform apply which will recreate the resource and execute the script.

The challange with null_resoruce is you need to perform terarform init to download the plugins and terraform plan to see the changes. This issue was resolved with terraform_data resource.

11. What is Terraform Data?
Its similar to null_resource but it does not require terraform init and terraform plan. It does not have any lifecycle blocks. It is used to run provisioners.

12. I want to null_respurce or terraform_data to run only when the Tags of the resource is changed. How can I do that?
A: We can use triggers block to run the resource only when the tags are changed.
triggers_replace = element(aws_instance.web-1.*.tags.Version, count.index)

