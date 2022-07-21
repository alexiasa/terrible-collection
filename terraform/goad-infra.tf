terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_ebs_volume" "goad_ebs" {
  availability_zone = "us-west-2c"
  size              = 40

  tags = {
    Name    = "goad-storage"
    purpose = "lab"
  }
}

resource "aws_volume_attachment" "goad_volume" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.goad_ebs.id
  instance_id = aws_instance.goad_host.id
}

resource "aws_instance" "goad_host" {
  ami           = "ami-04a32162efe87cb4c"
  instance_type = "t2.2xlarge"
  key_name      = "kp-goad-us-west-2"

  tags = {
    Name    = "goad-host"
    purpose = "lab"
  }
}
