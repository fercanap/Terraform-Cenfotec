data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=*ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" --query 'Images|sort_by(@, &CreationDate)|[-1].[ImageId, Name]'
# aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=*ubuntu/images/hvm-ssd/ubuntu-jammy-22.04*" --query 'Images|sort_by(@, &CreationDate)|[-1].[ImageId, Name]'
