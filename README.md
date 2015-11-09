# `faithlife/node-consul` Docker Image
### A small base for node projects that use consul.

This image adds [Consul](https://consul.io) to [`faithlife/node`](https://github.com/faithlife/docker-node).

###### Configuration

Place the configuration in `/etc/consul.d`.

For blue/green deployments, place the color-specific consul configuration along with the common configuration in `/etc/consul.d/<color>`.

To start Consul, run `/etc/init.d/consul start <join IP> [color]`.
