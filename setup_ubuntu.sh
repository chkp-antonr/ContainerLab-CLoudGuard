#!/bin/bash
DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y iproute2 iputils-ping openssh-server mtr
service ssh start

