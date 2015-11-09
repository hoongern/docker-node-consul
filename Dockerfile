FROM faithlife/node

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

# Register consul init.d
COPY consul.init.d /etc/init.d/consul
RUN chmod 755 /etc/init.d/consul

EXPOSE 8301 8301/udp

ENTRYPOINT ["node"]
