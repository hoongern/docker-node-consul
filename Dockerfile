FROM faithlife/node:4.4.0-rc.2

ENV CONSUL_VERSION=0.5.2

# Install consul
RUN export GOPATH=/go && \
  apk add --update go gcc musl-dev make bash && \
  go get github.com/hashicorp/consul && \
  cd $GOPATH/src/github.com/hashicorp/consul && \
  git checkout -q --detach "v$CONSUL_VERSION" && \
  make && \
  mv bin/consul /bin && \
  rm -rf $GOPATH && \
  apk del go gcc musl-dev make bash && \
  rm -rf /var/cache/apk/*

# Install envconsul
ADD https://github.com/hashicorp/envconsul/releases/download/v0.6.0/envconsul_0.6.0_linux_amd64.zip /tmp/envconsul.zip
RUN cd /bin && unzip /tmp/envconsul.zip && chmod +x /bin/envconsul && rm /tmp/envconsul.zip

# Register consul init.d
COPY consul.init.d /etc/init.d/consul
RUN chmod 755 /etc/init.d/consul

EXPOSE 8301 8301/udp

ENTRYPOINT ["node"]
