FROM nginx:1.13.7

RUN mkdir -p /var/www/ /var/static/ /var/media/

COPY src/conf/nginx.conf /etc/nginx/nginx.conf
COPY src/api/static/* /var/static/

EXPOSE 80

CMD nginx -g 'daemon off;'