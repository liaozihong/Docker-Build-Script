FROM eboraas/apache-php
MAINTAINER dashuai <911858173@qq.com>

RUN apt-get update && apt-get -y install memcached php5-memcache && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD https://github.com/junstor/memadmin/archive/v1.0.12.tar.gz /var/www
RUN rm -fr /var/www/html && ln -s /var/www/memadmin-1.0.12 /var/www/html && cd /var/www/ && tar xvf v1.0.12.tar.gz
