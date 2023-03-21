# Declare the AWS provider and region
provider "aws" {
  region = "us-west-2"
}
#vpc_id              = "vpc-0a3bb13efceeebf60"
#subnet_ids			= "subnet-0cb6fe034fccb9301"
# Declare the VPC ID and subnet IDs
variable "vpc_id" {}
variable "subnet_ids" {}

# Create a security group for the RDS instance
resource "aws_security_group" "rds" {
  name_prefix = "rds-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "example" {
  name        = "example-subnet-group"
  description = "Example DB subnet group"
  subnet_ids  = ["subnet-0cb6fe034fccb9301", "subnet-0b791bcc26bf36717"]
}
# Create the RDS instance
resource "aws_db_instance" "example" {
  identifier            = "example-db"
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t2.micro"
  allocated_storage     = 20
  storage_type          = "gp2"
 # backup_retention_days = 7
  username              = "admin"
  password              = "password123"
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = "example-subnet-group"
  #delete_protection 	 = true
  skip_final_snapshot    = true
  # Set the subnet group IDs
  #subnet_group_ids = var.subnet_ids

  # Add tags to the RDS instance
  tags = {
    Name = "example-db"
  }
}
