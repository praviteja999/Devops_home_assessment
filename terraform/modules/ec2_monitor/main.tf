
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "monitor" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = []
  key_name               = var.key_name

  tags = {
    Name        = "global-monitor"
    Environment = "shared"
    Role        = "monitoring"
  }
}
