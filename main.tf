data "aws_ami" "ami-existing" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
resource "aws_instance" "AshuVM-1" {
  ami = data.aws_ami.ami-existing.id
  provider = aws.dr
  user_data = file("./app1-install.sh")
  instance_type = var.instance_type
  key_name = var.instance_keypair
 #availability_zone = var.az
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id] 
  subnet_id = aws_subnet.subnet1.id
  tags = {
          Name : "AshuhostTest"
          env : "ProdTest"
  }
  
}

output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.AshuVM-1.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.AshuVM-1.public_dns
}