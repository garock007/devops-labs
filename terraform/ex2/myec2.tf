provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAR4KJP3BG5HX6E5MF"
  secret_key = "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"

}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instancetype
  key_name      = "devops-msm"
  tags = var.aws_common_tag
  security_groups = [aws_security_group.allow_http_https.name]
}

data "aws_ami" "app_ami" {
   most_recent = true 
   owners = ["amazon"]

   filter {
      name = "name"
      values = ["amzn2-ami-hvm*"]
   }
}



resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}


resource "aws_security_group" "allow_http_https" {
  name        = "exapp-2-sg"
  description = "Autoriser http et https pour le traffic en entree"

  ingress {
    description = "HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = " HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


