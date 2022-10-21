#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt-get install proftpd-basic -y

sudo systemctl start proftpd

sudo echo "/bin/false" >> /etc/shells

sudo systemctl restart proftpd

sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -days 365

echo -e "<IfModule mod_tls.c>\n TLSEngine on\n    TLSLog /var/log/proftpd/tls.log\n    TLSProtocol TLSv1.2\n    TLSRSACertificateFile /etc/ssl/certs/proftpd.crt\n    TLSRSACertificateKeyFile /etc/ssl/private/proftpd.key\n	TLSverifyClient off\n	TLSOptions NoSessionReuseRequired\n	TLSRequiredon\n	<IfModule>" >> /etc/proftpd/conf.d/tls.conf

sudo chmod 600 /etc/ssl/certs/proftpd.crt
sudo chmod 600 /etc/ssl/private/proftpd.key

sudo sed -i '13iInclude /etc/proftpd/tls.conf' /etc/proftpd/proftpd.conf

sudo systemctl restart proftpd

sudo addgroup ftpgroup

adduser User1 --force-badname --shell /bin/false --home /var/www/User1
