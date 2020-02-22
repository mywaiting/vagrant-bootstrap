#!/usr/bin/env bash


# 
#
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# Parts Below MUST execute as vagrant user or your development env user!!!!
# 
# 


echo "--------------------------"
echo " Install PHP pyenv     "
echo "--------------------------"


# mariadb
apt-get install -y mariadb-server php-mysql

# mysql -u root
# \q
# mysql_secure_installation
# Y for all

# php-fpm
apt-get install -y php-fpm


# nginx
apt-get install -y nginx

# wordpress nginx conf. FOR PHP7.2-FPM !!!!!!
cat > ~/wordpress.conf << __EOF__
server {
    listen         80;
    server_name    wordpress-example-test-site.com;
    root           /var/www/wordpress/;
    index          index.html index.htm index.php;

    location / {
        try_files $uri $uri/ /index.php?q=$uri&$args;
    }

    location ~ \.php$ {
        include fastcgi.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock; # FOR PHP7.2-FPM !!!!!!
    }
}
__EOF__

# typecho nginx conf. FOR PHP7.2-FPM !!!!!!
cat > ~/typecho.conf << __EOF__
server {
    listen         80;
    listen         [::]:80;
    server_name    typecho-example-test-site.com;
    root           /var/www/typecho;
    index          index.html index.htm index.php;

    if (!-e $request_filename) {
        rewrite ^(.*)$ /index.php$1 last;
    }

    location ~ .*\.php(\/.*)*$ {
      fastcgi_pass    unix:/run/php/php7.2-fpm.sock; # FOR PHP7.2-FPM !!!!!!
      include         fastcgi_params;
      fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
      fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }
}
__EOF__

cp ~/*.conf   /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/*.conf   /etc/nginx/sites-enabled/

nginx -s reload
nginx -t