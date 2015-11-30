FROM faithlife/node:5.1

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

# Install consul-template
ADD https://github.com/hashicorp/consul-template/releases/download/v0.11.0/consul_template_0.11.0_linux_amd64.zip /tmp/consultemplate.zip
RUN cd /bin && unzip /tmp/consultemplate.zip && chmod +x /bin/consul-template && rm /tmp/consultemplate.zip

# Register consul init.d
COPY consul.init.d /etc/init.d/consul
RUN chmod 755 /etc/init.d/consul

EXPOSE 8301 8301/udp

ENTRYPOINT ["node"]
