#!/bin/bash

sudo systemctl stop proftpd* -y

sudo apt-get remove --purge proftpd* -y

sudo systemctl stop ftp* -y

sudo apt-get remove --purge ftp* -y

sudo groupdel ftpgroup -f

echo "Done"
