FROM mariadb/server:10.4

RUN printf "[mysqld]\ninnodb_buffer_pool_size = 512M" > /etc/mysql/conf.d/greater_innodb_buffer_pool_size.cnf && \
    printf "[mysqld]\nmax_allowed_packet = 128M" > /etc/mysql/conf.d/greater_max_allowed_packet.cnf
