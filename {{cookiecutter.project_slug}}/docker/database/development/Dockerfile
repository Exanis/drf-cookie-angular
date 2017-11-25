FROM postgres:10.1

RUN mkdir -p /docker-entrypoint-initdb.d
COPY src/init-user.sh /docker-entrypoint-initdb.d/