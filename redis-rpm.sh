yum -y install ruby rubygems ruby-devel
gem sources -a http://rubygems.org
gem sources --remove https://rubygems.org
gem install fpm
wget http://download.redis.io/releases/redis-3.2.3.tar.gz
tar -xvf redis-3.2.3.tar.gz -C /usr/local/
ln -s /usr/local/redis-3.2.3 /usr/local/redis
cd /usr/local/redis && make
echo '#!/bin/bash
ln -s /usr/local/redis/src/redis-server /usr/bin/
ln -s /usr/local/redis/src/redis-cli /usr/bin/  
ln -s /usr/local/redis/src/redis-benchmark /usr/bin/
ln -s /usr/local/redis/src/redis-check-rdb /usr/bin/
ln -s /usr/local/redis/src/redis-check-aof /usr/bin/' >/tmp/redis_cmd.sh
echo '#!/bin/bash
rm -rf /usr/bin/redis-server /usr/bin/redis-cli /usr/bin/redis-benchmark /usr/bin/redis-check-rdb /usr/bin/redis-check-aof /usr/local/redis'>/tmp/redis_uninstall
fpm -s dir -t rpm -n redis -v 3.2.3 --post-install /tmp/redis_install --post-uninstall /tmp/redis_uninstall -f /usr/local/redis/