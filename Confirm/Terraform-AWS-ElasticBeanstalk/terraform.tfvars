vpc_id              = "vpc-0a3bb13efceeebf60"
Instance_type       = "t2.medium"
minsize             = 1
maxsize             = 2
public_subnets     = ["subnet-0cb6fe034fccb9301", "subnet-0b791bcc26bf36717"] # Service Subnet
elb_public_subnets = ["subnet-0cb6fe034fccb9301", "subnet-0b791bcc26bf36717"] # ELB Subnet
tier = "WebServer"
solution_stack_name= "64bit Amazon Linux 2 v5.7.0 running Node.js 16"