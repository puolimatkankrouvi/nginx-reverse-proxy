FROM ubuntu:24.04

RUN apt update
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt-get clean

COPY ./docker/nginx/nginx.conf  etc/nginx/nginx.conf
COPY ./docker/nginx/sites-available/reverse-proxy.conf etc/nginx/sites-available/reverse-proxy

RUN unlink /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]