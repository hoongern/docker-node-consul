FROM faithlife/node:4.4

ENV CONSUL_VERSION=0.6.4

# Install consul
RUN curl -sL -o /tmp/consul.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
  unzip /tmp/consul.zip -d /bin && \
  chmod +x /bin/consul && \
  rm /tmp/consul.zip


# Install envconsul
RUN curl -sL -o /tmp/envconsul.zip https://github.com/hashicorp/envconsul/releases/download/v0.6.0/envconsul_0.6.0_linux_amd64.zip && \
  unzip /tmp/envconsul.zip -d /bin && \
  chmod +x /bin/envconsul && \
  rm /tmp/envconsul.zip

# Register consul init.d
COPY consul.init.d /etc/init.d/consul
RUN chmod 755 /etc/init.d/consul

EXPOSE 8301 8301/udp

ENTRYPOINT ["node"]
