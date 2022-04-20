
FROM docker.io/library/python:3.9-slim

# debian-slim based python container with libzim

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends vim cron libmagic1 wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /scripts && \
    wget -O /sbin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 \
    && chmod +x /sbin/dumb-init && \
    mkdir -p /data

VOLUME /data

RUN pip install -U "zimscraperlib>=1.4.3,<1.5" && \
    printf "#!/bin/bash\n\n\
chmod +x /usr/local/bin/* 2> /dev/null\n\n\
\
if [ -f /usr/local/bin/startup ]; then\n\
    echo \"Launching startup script…\"\n\
    /usr/local/bin/startup || exit \$?\n\
fi\n\n\
\
echo \"starting…\"\n\
exec \"\$@\"" > /sbin/entrypoint && chmod +x /sbin/entrypoint

ENTRYPOINT ["dumb-init", "--", "entrypoint"]
CMD ["cron", "-f"]

