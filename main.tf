locals {
  # Change sub_id depending on the av_zone
  # eu-west-1a: subnet-0e77c45fd6611d0b0
  # eu-west-1b: subnet-05148711022dfabd5
  # eu-west-1c: subnet-0ee0369ab3d454e44

  inf_name = "CARBONIOCLOUD"

  #domain = "carboniocloud.com"

  #1A MEDIUM
  medium_1a = tolist(["SD01-${local.inf_name}","LDAP01-${local.inf_name}","PROXY01-${local.inf_name}","FILES01-${local.inf_name}","MX01-${local.inf_name}","OUT01-${local.inf_name}"])
  hostname_m1a = tolist(["sd01","ldap01","proxy01","files01","mx01","out01"])

  #1B MEDIUM
  medium_1b = tolist(["LDAP02-${local.inf_name}","OUT02-${local.inf_name}"])
  hostname_m1b = tolist(["ldap02","out02"])

  #1C MEDIUM
  medium_1c = tolist(["OUT03-${local.inf_name}","FILES02-${local.inf_name}"])
  hostname_m1c = tolist(["out03","files02"])

  #1A LARGE
  large_1a = tolist(["VIDEO01-${local.inf_name}"])
  hostname_l1a = tolist(["video01"])

  #1A XLARGE
  xlarge_1a = tolist(["MBOX01-${local.inf_name}"])
  hostname_xl1a = tolist(["mbox01"])

  sub1a = "subnet-0e77c45fd6611d0b0"
  sub1b = "subnet-05148711022dfabd5"
  sub1c = "subnet-0ee0369ab3d454e44"

  sub_sg = ["sg-0c2527ec995d77cf0"]

  os = "UBUNTU20.04"
  av_zone1a = "eu-west-1a"
  av_zone1b = "eu-west-1b"
  av_zone1c = "eu-west-1c"

}

resource "aws_instance" "server-1a-medium" {
  count 			= length(local.medium_1a)
  ami				= "ami-0935256c204fa0ec0"
  key_name			= "clienti"
  instance_type 		= "t3a.medium"
  disable_api_termination 	= true
  availability_zone 		= local.av_zone1a
  vpc_security_group_ids		= local.sub_sg
  subnet_id			= local.sub1a
  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data = <<EOF
#!/bin/bash
echo "Changing hostname"
hostname "${local.hostname_m1a[count.index]}"
echo "${local.hostname_m1a[count.index]}" > /etc/hostname
sed -i "s/AWS SOMETHING/ZextrasCloud ${local.medium_1a[count.index]} AWS/" /root/.bashrc
sed -i "s/^preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg
EOF

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 4
    volume_type = "standard"
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1a[count.index]}-SWAP"
      SERVIZIO = local.inf_name
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1a[count.index]}-ROOT"
      SERVIZIO = local.inf_name
    }
  }

  #opt
  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.medium_1a[count.index]}-ZOPT"
      SERVIZIO = local.inf_name
    }
  }

  tags = {
    Name = local.medium_1a[count.index]
    OS = local.os
    SERVIZIO = local.inf_name
  }
  
}

resource "aws_instance" "server-1b-medium" {
  count                         = length(local.medium_1b)
  ami                           = "ami-0935256c204fa0ec0"
  key_name                      = "clienti"
  instance_type                 = "t3a.medium"
  disable_api_termination       = true
  availability_zone             = local.av_zone1b
  vpc_security_group_ids               = local.sub_sg
  subnet_id                     = local.sub1b
  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data = <<EOF
#!/bin/bash
echo "Changing hostname"
hostname "${local.hostname_m1b[count.index]}"
echo "${local.hostname_m1b[count.index]}" > /etc/hostname
sed -i "s/AWS SOMETHING/ZextrasCloud ${local.medium_1b[count.index]} AWS/" /root/.bashrc
sed -i "s/^preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg
EOF

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 4
    volume_type = "standard"
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1b[count.index]}-SWAP"
      SERVIZIO = local.inf_name
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1b[count.index]}-ROOT"
      SERVIZIO = local.inf_name
    }
  }

  #opt
  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.medium_1b[count.index]}-ZOPT"
      SERVIZIO = local.inf_name
    }
  }

  tags = {
    Name = local.medium_1b[count.index]
    OS = local.os
    SERVIZIO = local.inf_name
  }

}

resource "aws_instance" "server-1c-medium" {
  count                         = length(local.medium_1c)
  ami                           = "ami-0935256c204fa0ec0"
  key_name                      = "clienti"
  instance_type                 = "t3a.medium"
  disable_api_termination       = true
  availability_zone             = local.av_zone1c
  vpc_security_group_ids               = local.sub_sg
  subnet_id                     = local.sub1c
  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data = <<EOF
#!/bin/bash
echo "Changing hostname"
hostname "${local.hostname_m1c[count.index]}"
echo "${local.hostname_m1c[count.index]}" > /etc/hostname
sed -i "s/AWS SOMETHING/ZextrasCloud ${local.medium_1c[count.index]} AWS/" /root/.bashrc
sed -i "s/^preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg
EOF

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 4
    volume_type = "standard"
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1c[count.index]}-SWAP"
      SERVIZIO = local.inf_name
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
    tags = {
      Name = "${local.medium_1c[count.index]}-ROOT"
      SERVIZIO = local.inf_name
    }
  }

  #opt
  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.medium_1c[count.index]}-ZOPT"
      SERVIZIO = local.inf_name
    }
  }

  tags = {
    Name = local.medium_1c[count.index]
    OS = local.os
    SERVIZIO = local.inf_name
  }

}

resource "aws_instance" "server-1a-large" {
  count                         = length(local.large_1a)
  ami                           = "ami-0935256c204fa0ec0"
  key_name                      = "clienti"
  instance_type                 = "t3a.large"
  disable_api_termination       = true
  availability_zone             = local.av_zone1a
  vpc_security_group_ids               = local.sub_sg
  subnet_id                     = local.sub1a
  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data = <<EOF
#!/bin/bash
echo "Changing hostname"
hostname "${local.hostname_l1a[count.index]}"
echo "${local.hostname_l1a[count.index]}" > /etc/hostname
sed -i "s/AWS SOMETHING/ZextrasCloud ${local.large_1a[count.index]} AWS/" /root/.bashrc
sed -i "s/^preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg
EOF

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 4
    volume_type = "standard"
    delete_on_termination = true
    tags = {
      Name = "${local.large_1a[count.index]}-SWAP"
      SERVIZIO = local.inf_name
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
    tags = {
      Name = "${local.large_1a[count.index]}-ROOT"
      SERVIZIO = local.inf_name
    }
  }

  #opt
  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.large_1a[count.index]}-ZOPT"
      SERVIZIO = local.inf_name
    }
  }

  tags = {
    Name = local.large_1a[count.index]
    OS = local.os
    SERVIZIO = local.inf_name
  }

}

resource "aws_instance" "server-1a-xlarge" {
  count                         = length(local.xlarge_1a)
  ami                           = "ami-0935256c204fa0ec0"
  key_name                      = "clienti"
  instance_type                 = "t3a.xlarge"
  disable_api_termination       = true
  availability_zone             = local.av_zone1a
  vpc_security_group_ids               = local.sub_sg
  subnet_id                     = local.sub1a
  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data = <<EOF
#!/bin/bash
echo "Changing hostname"
hostname "${local.hostname_xl1a[count.index]}"
echo "${local.hostname_xl1a[count.index]}" > /etc/hostname
sed -i "s/AWS SOMETHING/ZextrasCloud ${local.xlarge_1a[count.index]} AWS/" /root/.bashrc
sed -i "s/^preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg
EOF

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 4
    volume_type = "standard"
    delete_on_termination = true
    tags = {
      Name = "${local.xlarge_1a[count.index]}-SWAP"
      SERVIZIO = local.inf_name
    }
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    delete_on_termination = true
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ROOT"
      SERVIZIO = local.inf_name
    }
  }

  #index
  ebs_block_device {
    device_name = "/dev/sdd"
    volume_size = 100
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZINDEX"
      SERVIZIO = local.inf_name
      SNAPSHOT = "4h"
    }
  }

  #db
  ebs_block_device {
    device_name = "/dev/sde"
    volume_size = 50
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZDB"
      SERVIZIO = local.inf_name
      SNAPSHOT = "4h"
    }
  }

  #metadata
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 50
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZMETADATA"
      SERVIZIO = local.inf_name
    }
  }

  #zlog
  ebs_block_device {
    device_name = "/dev/sdg"
    volume_size = 30
    volume_type = "standard"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZLOG"
      SERVIZIO = local.inf_name
    }

  }

  #zsysbackup
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 21
    volume_type = "standard"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZSYSBACKUP"
      SERVIZIO = local.inf_name
      SNAPSHOT = "12h"
    }

  }

  #cache
  ebs_block_device {
    device_name = "/dev/sdi"
    volume_size = 25
    volume_type = "standard"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-CACHE"
      SERVIZIO = local.inf_name
    }
  }

  #store
  ebs_block_device {
    device_name = "/dev/sdl"
    volume_size = 50
    volume_type = "gp3"
    delete_on_termination = false
    tags = {
      Name = "${local.xlarge_1a[count.index]}-ZSTORE"
      SERVIZIO = local.inf_name
      SNAPSHOT = "4h"
    }
  }

  tags = {
    Name = local.xlarge_1a[count.index]
    OS = local.os
    SERVIZIO = local.inf_name
  }

}
