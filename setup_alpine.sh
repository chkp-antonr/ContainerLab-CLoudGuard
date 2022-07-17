#!/bin/sh
apk update
apk add openssh
ssh-keygen -A
/usr/sbin/sshd -D &

