FROM golang:1.22.0-alpine


# Copy the compiled binaries from the builder stage
COPY build/alertmanager /bin/alertmanager
COPY build/amtool /bin/amtool
COPY build/examples/ha/alertmanager.yml      /etc/alertmanager/alertmanager.yml

RUN mkdir -p /etc/alertmanager

RUN mkdir -p /alertmanager && \
    chown -R nobody:nobody /etc/alertmanager /alertmanager

USER       nobody
EXPOSE     9093
VOLUME     [ "/alertmanager" ]
WORKDIR    /alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--config.file=/etc/alertmanager/alertmanager.yml", \
             "--storage.path=/alertmanager" ]
