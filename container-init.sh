#! /usr/bin/env bash

wp core download --force --allow-root
wp config create \
  --dbhost=$WORDPRESS_DB_HOST \
  --dbname=$WORDPRESS_DB_NAME \
  --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD \
  --allow-root
wp core install \
  --title=$TITLE \
  --url=$URL \
  --admin_user=$ADMIN_USER \
  --admin_password=$ADMIN_PASSWORD \
  --admin_email=$ADMIN_EMAIL \
  --allow-root
chown -R www-data:www-data wp-content
chmod -R g+w wp-content
# add for skip creation default themes
  --skip-themes
# add for skip creation default plugins
  --skip-plugins
  --allow-root

# Test we can access the db container allowing for start
# for i in {1..50}; do mysql -u root -p${MYSQL_ROOT_PASSWORD} -h db -e "show databases" && s=0 && break || s=$? && sleep 2; done
# if [ ! $s -eq 0 ]; then exit $s; fi

# Init some stuff in db before leaving the floor to the application
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -h db -e "create database my_app"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -h db -e "create table my_app.test (id int unsigned not null auto_increment primary key, myval varchar(255) not null)"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -h db -e "insert into my_app.test (myval) values ('toto'), ('pipo'), ('bingo')"