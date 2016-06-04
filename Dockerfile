FROM node:5-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx-light git net-tools sudo bzip2


COPY ./nginx /etc/nginx
COPY ./rwa /var/www/angular

WORKDIR /var/www/angular
COPY ./.env /var/www/angular/
RUN npm install
RUN npm install -g nodemon

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
