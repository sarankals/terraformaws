#! /bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html/
echo "<h1> Deployed using HTML </h1>" >index.html
