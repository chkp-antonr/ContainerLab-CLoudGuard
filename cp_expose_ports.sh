#!/bin/bash
/usr/bin/nohup /usr/bin/socat TCP-LISTEN:19009,fork TCP:127.0.0.1:19009 &
/usr/bin/nohup /usr/bin/socat TCP-LISTEN:18264,fork TCP:127.0.0.1:18264 &
/usr/bin/nohup /usr/bin/socat TCP-LISTEN:18190,fork TCP:127.0.0.1:18190 &
