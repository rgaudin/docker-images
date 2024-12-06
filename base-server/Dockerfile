FROM alpine:3.20 as builder
RUN apk --no-cache add build-base gcc make
RUN wget https://www.acme.com/software/thttpd/thttpd-2.29.tar.gz && \
    tar xf thttpd-2.29.tar.gz && \
    rm -f ./thttpd-2.29.tar.gz && \
    cd thttpd-2.29 && \
    echo "json application/json" >> mime_types.txt && \
    ./configure --host="$(uname -m)-linux" && \
    make && \
    cd .. && \
    mv thttpd-2.29/thttpd / && \
    rm -rf ./thttpd-2.29

FROM alpine:3.20
COPY --from=builder /thttpd /usr/sbin/thttpd
WORKDIR /var/www/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/thttpd"]
CMD ["-D", "-l", "/dev/stdout", "-nos", "-r"]
