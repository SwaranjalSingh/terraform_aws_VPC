#####------Creating VPC---------#####
resource "aws_vpc" "VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Swaranjal"
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }
}
#####------Creating 1st Subnet---------#####
resource "aws_subnet" "Subnet-02" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.1.0/24"

 tags = {
    Name = "Swaranjal"
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }
}
#####------Creating 2nd Subnet---------#####
resource "aws_subnet" "Subnet-1" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.2.0/24"

 tags = {
    Name = "Swaranjal"
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }
}
#####------Creating Security Group---------#####
resource "aws_security_group" "SG" {
  vpc_id = aws_vpc.VPC.id
    ingress {                       //Inbound Traffic
        description = "Http"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80              //80 for http port
        to_port = 80
        protocol = "TCP"
    }
    ingress {                       //Inbound Traffic
        description = "Https"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 443                //443 for https port
        to_port = 443
        protocol = "TCP"
    }
 // Terraform removes the default rule
  egress {                             //Outbound Traffic
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    tags = {
            Name = "Swaranjal"
            Owner = "Swaranjal.singh@cloudeq.com"
            Purpose = "Training"
        }
}

#####------Creating 1st subnet's 2 instances---------#####
resource "aws_instance" "subnet-1-servers" {
  count = length(var.subnet-1-ec2)
  subnet_id     = aws_subnet.Subnet-1.id
  ami           = "ami-0f1a5f5ada0e7da53"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.SG.id}"]
  tags = {
    Name = var.subnet-1-ec2[count.index]
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }
  volume_tags = {
    Name = var.subnet-1-ec2[count.index]
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"  }
}
#####------Creating 2nd subnet's 2 instances---------#####
resource "aws_instance" "subnet-2-servers" {
  count = length(var.subnet-2-ec2)
  subnet_id     = aws_subnet.Subnet-02.id
  ami           = "ami-0f1a5f5ada0e7da53"
  instance_type = "t2.micro"
  security_groups =  ["${aws_security_group.SG.id}"]

  tags = {
    Name = var.subnet-2-ec2[count.index]
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }

  volume_tags = {
    Name = var.subnet-2-ec2[count.index]
    Owner = "Swaranjal.singh@cloudeq.com"
    Purpose = "Training"
  }
}