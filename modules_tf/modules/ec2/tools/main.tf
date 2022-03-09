resource "aws_network_interface" "ni_tools" {
  subnet_id                 = var.subnet_id
  private_ips               = ["${replace(var.cidr_block_d, "0/24", "101")}"]
}

resource "aws_instance" "ec2_tools" {
    ami                     = var.ec2_ami_id
    instance_type           = "t3.medium"
    #vpc_security_group_ids  = [var.ec2_sg_id]
    #subnet_id               = var.subnet_id
    iam_instance_profile    = var.instance_profile
    #secondary_private_ips   = ["${replace(var.cidr_block_d, "0/24", "101")}"]
    network_interface {
    device_index            = 0
    network_interface_id    = aws_network_interface.ni_tools.id
    }
    credit_specification {
      cpu_credits           = "unlimited"
    }

      lifecycle {
    ignore_changes = all
  }
    root_block_device {
          #device_name           = "/dev/xvda"
          encrypted         = true
          iops              = 120
          volume_size       = 40
    }
    user_data               = <<EOF


#!/bin/bash
# Change Local hostname
sudo hostnamectl set-hostname workera-${var.environment}-tools.localdomain
echo "HOSTNAME=workera-${var.environment}-tools" >> /etc/sysconfig/network
echo "127.0.0.1  workera-${var.environment}-tools.localdomain workera-${var.environment}-tools localhost4 localhost4.localdomain4" >> /etc/hosts

echo ############################################### Vanta Agent
VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"


echo "###############################################  Install Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "###############################################  Install Docker-Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
yum install -y git jq vim unzip
yum remove -y postgresql postgresql-server
yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-latest-x86_64/postgresql10-libs-10.7-2PGDG.rhel7.x86_64.rpm
yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-latest-x86_64/postgresql10-10.7-2PGDG.rhel7.x86_64.rpm
yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-latest-x86_64/postgresql10-server-10.7-2PGDG.rhel7.x86_64.rpm
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAwmEwkXNXBiKBVSoHjWJ/1s0/OLafNpdIAxmhWSOyyXb31y5+
rMhZZckDp2nk7jN3+g1XS+GvMvZbRJ3lmD3A0A5jJSxWSwLoFwJtdMfjZiaIKGxM
MWX1aKrBUw3pnH7H/sISSMa0uOk5i6723qTIx/epyPcyuOGktIt82qTHNWhuJLzL
OOb07qoQPdNVHhOGs5wvmUEJ8MIb+U99sLIifkhIaxriRxqTAGLs6mD/KxR/xQ2e
HVfNdy4UQghybp+1PzmmAxOeV6RWJy8Z8DDCQzRfFiuAVlLFVYWRzKi6LHcc7nT1
4//yT3UVRxefiM1o7Vp+C0bPLIC1Lo1VRIEjcQIDAQABAoIBAACz80YDYcQu6cLS
FRbozUeMlHbzCh5ba7I/LHszCtl5qanIjEK5ssEQegfn9SD7ZKqt06v9k/GePHRC
Eet8Ba967dbbkzBQQWCb7KNoeaUL7KAgzCG9maaYP3y6ZybeuoBsWT6UIWEtzrx3
lIL3m5ZFigKlCjTq8/qHKptrzyCdT3NZq9OBMXF0vV95rfgzDSg1xVbdSllapfrN
5uPpYclsT48R+W3MmdL+r8hpSjoRwHNLoKFvPwpgXuffz1+eR+3K7mqB7B5MzsCO
VWTzO/aKY5tVjAnsLbLqHAdE6VtJ8267IBK4YpUtUSBk3B7/9LS4X+dWkacEC+w9
W25DaGUCgYEA52EWXCkgNtNWl/yuIzk3pY7zbSR1CyeRHkZaG/c2pNGl5tHBm59S
Ow/XqFm8+u07Frjc5ut94A9vRPFqnDVxRlmMvssIGlky18gfAND515B3BLhzq1oo
+9JplYm/a4E+5DXEmNjzZIQHbaaFf6xUU6r91gbiwFLQGEKQIhuP6TMCgYEA1xA1
59m/PN2PEFNzkRRdHVmqU5fDH5MvjN9fkXQOuDbKXfJtQpROsPM7k0/AfemehRS/
YLbYVYJOKt1YcDmN+ijMAKtB7Zw6WUC5vQBKdB900pBR5K4oCSRC7uPr3zHolwot
3+kRoKFpAZfxs/70ikRvbOsJVYKFePeRifu/6MsCgYEAxb2Sh3baQiDBi6j2BcJb
jVErNuaGZN8OxanoTqgq+hb1ytsOtHono7Q5YXY37NcbvaKFn5A4hmmKdYhAzXla
8n2LrG8F4MbEjedIn8D5FMIxBUbCC/pEtlovxA3yGuVdI1nUR7B56jhvxMUgqGlV
tB+ZSfWeijD8CQ+x8IRPrEMCgYEAxUEbEDKJ0vusEl9YakLxPNBXByD1WOqY/G6M
q051icTHS+/lAuIgYvBVPkIx3cr/GDT1a3GJbrR7mZk3WoePj1kH870gVR2r7t0M
/ytbHrMTZWX1lvedxPS7Z30phKe0G4S8mtic0GX7d/izOlKoXIF0acQR5Zo3bcI0
fQio9o0CgYB3dFw2KV0gsaJqoPWxgnyu7fXl/0mOWI3uaw6GFKfwEE7UclS6eceL
4fXfq/NiT1Uu+L7VbCg7PEB06/bdorJKupduRzmAnEE3Z8uicN7uDtedW/wGt3dQ
Da0Ncc3E48RBhdVL5RquJ7ufwJ414dnNbutB6kNzL/YE5P80KKU17A==
-----END RSA PRIVATE KEY-----" >> /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keyscan github.com >> /root/.ssh/known_hosts
cd /root && git clone --recurse-submodules git@github.com:deeplearning-ai/workera-iac.git workera-tools

echo "############################################### Install AWS CLI 2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "###############################################  ECR COMMAND"
/usr/local/bin/aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.owner}.dkr.ecr.us-east-2.amazonaws.com

echo "###############################################  MOUNT EFS"
mkdir /root/efs-odoo
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${var.efs_odoo_id}.efs.${var.region}.amazonaws.com:/  /root/efs-odoo

echo "############################################### CREATE ENV"
HOST=$(/usr/local/bin/aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text | jq -r .RDS_HOSTNAME)
DBUSER=$(/usr/local/bin/aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text | jq -r .TAD_USERNAME)
BOCHICADB=$(/usr/local/bin/aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text | jq -r .ODOO_BACKOFFICE_DATABASE)
WORKERADB=$(/usr/local/bin/aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text | jq -r .RDS_DB_NAME)
PASSWORD=$(/usr/local/bin/aws secretsmanager get-secret-value --secret-id ${var.secret_name} --query SecretString --output text | jq -r .TAD_PASSWORD)

echo "WORKERADB=$WORKERADB
BOCHICADB=$BOCHICADB
DBUSER=$DBUSER
PASSWORD=$PASSWORD
DBHOST=$HOST
ADMINER_DEFAULT_SERVER=$HOST" > /root/workera-tools/tools/.env

echo "############################################### LAUNCH DC"
cd /root/workera-tools/tools/ && docker-compose up -d

EOF

  tags = {
       Name               = "${var.app_name}-${var.environment}-tools"
  }

}