packer {
  required_plugins {
    amazon = {
      version = "~> 1.1.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-aws-ubuntufocal-tfcagent-3"
  instance_type = "t3.large"
  region        = "eu-north-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-*-amd64-server-**"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["679593333241"] # Cannonical Limited ltd.
  }
  ssh_username = "ubuntu"
}

build {
  name    = "ubuntufocal-tfe-agent"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    script = "scripts/packages.sh"
  }
}
