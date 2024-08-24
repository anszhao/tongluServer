#!/usr/bin/env bash

echo "Install fast plus google bbr software and run it on server"
#Install fast plus google bbr software and run it on server
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

echo "Check bbr service is running"
#Check bbr service is running
lsmod | grep bbr

echo "Install SS server from git"
#Install SS server from git
wget — no-check-certificate -O shadowsocks.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh

#Change ss to x
chmod +x shadowsocks.sh

echo "Replace python to python3"
#Replace python to python3
sed -i 's/python setup/python3 setup/g' shadowsocks.sh

echo "Run deploy script and install ss server"
#Run deploy script and install ss server
./shadowsocks.sh 2>&1 | tee shadowsocks.log

echo "Change collections.abc"
#Change 'collections.MutableMapping' to 'collections.abc.MutableMapping'
sed -i 's/collections.MutableMapping/collections.abc.MutableMapping/g' /usr/local/lib/python3.12/dist-packages/shadowsocks-3.0.0-py3.12.egg/shadowsocks/lru_cache.py

echo "Open port xxx for this server"
#Open port xxx for this server
ufw allow 8877

echo "Restart SS server"
#Restart SS server
/etc/init.d/shadowsocks restart

/etc/init.d/shadowsocks status

echo "SS server deploy completed!!!, now you can use it!"
