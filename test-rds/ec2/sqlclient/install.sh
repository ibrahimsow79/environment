#!/bin/sh
yum update -y

useradd isow && mkdir /home/isow/.ssh && chown 700 /home/isow/.ssh && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4HsdsnkNa/Czac5duRGzD39BcFFd7407kY7s1dRfGBabccv7UXNyjRJ1weMxYpj5GWwv0AXxA9Se4rndysM2jELWFGNE8OxHZJE8SXB3dU+yjlT03na6SGk87OKmEEAYO5Q1PXkwfrhUZbLkPRyoZukbU72W9O9gznFFas+HEsCDkTaPhmwfVlOWHDzqFQj7Q3cSMrJu+1sErh1yyir/uweruuC4u5hqYutm9KDdNXH2EYFlPFf5l5rr7A0nvOJEF5nDk2INQTM5VB8TJJ7JbaCNijVpc2ixj1kxSwt5c8hKM8rBMpilMNB+gkk0inWo3Jxv4rn076mOba8NuMTPio/9ukUDl2UcOJkmXpAJdcC9IdnNLNH0z9bROej999bUVolcMn4DaGq+LDaVXW6cEMRl3/k0hy5PJ5J9j2/AawjElD4uNAPAndgNxVmU1Dc2CZ0b/Z5lrAmUAx2tOHw76tgN2BTdYKSgkEIPif+ygcOIurh5QZYY3U5W2IUouAoNmuehFKZ8gPS6DRBcnq9uLJ5V9TjcVOcUSQp3cziZ6zJYIp161zIo0QGxmNj/lALke++2gCETul2jxyLxiFjdtXmJwo6nxeky2caMg0j4P1YR0fq/mJKMW5fokwFnovdstSbN0RlaY7zgNIgT1bmwOHixFd89GJdgUDlsfEqz8JQ== ibrahim.sow@mutex-exterieur.fr" > /home/isow/.ssh/authorized_keys && chmod 600 /home/isow/.ssh/authorized_keys && chown -R isow:isow /home/isow

usermod -aG wheel isow
usermod -aG adm isow

# Ajout du groupe wheel pour faire un sudo sans qu'on leur réclame un password

echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

amazon-linux-extras install epel
yum update -y
yum -y install httpd php
chkconfig httpd on
wget https://d1rj8jzxfnqtlj.cloudfront.net/phpapp.zip
unzip phpapp.zip -d /var/www/html/
service httpd start
yum -y install mysql
