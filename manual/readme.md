# 수동설치

```bash
sudo apt install libcgroup-dev make acl zip unzip mariadb-server apache2 \
      php php-fpm php-gd php-cli php-intl php-mbstring php-mysql \
      php-curl php-json php-xml php-zip composer ntp


# https://www.domjudge.org/download

tar -xf domjudge-8.3.1.tar.gz

./configure --prefix=$HOME/domjudge
make domserver
sudo make install-domserver


```