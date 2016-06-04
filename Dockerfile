FROM node:5-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx-light git net-tools sudo bzip2

RUN npm install -g tsd@^0.6.0 typescript@^1.5.0

COPY ./nginx /etc/nginx
COPY ./rollingwithadvantage /var/www/angular

WORKDIR /var/www/angular
RUN tsd install angular2 es6-promise rx rx-lite
RUN npm install

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
