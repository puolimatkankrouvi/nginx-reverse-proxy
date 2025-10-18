FROM debian:12.12-slim

RUN apt update
RUN apt upgrade -y
RUN apt install nginx -y
RUN apt-get clean

COPY ./docker/nginx/nginx.conf  etc/nginx/nginx.conf
COPY ./docker/nginx/sites-available/reverse-proxy.conf etc/nginx/sites-available/reverse-proxy
COPY ./docker/nginx/var/www/html/ var/www/html/

# Unlink default configuration from enabled sites
RUN unlink /etc/nginx/sites-enabled/default

# Add reverse proxy to sites enabled
RUN ln -s /etc/nginx/sites-available/reverse-proxy /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]