ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

# Setup base
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add tinc && \
    rm -rf /tmp/*

# Copy Bash script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]