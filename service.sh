#!/bin/bash
set -e ;\
  ip -4 route list match 0/0 | awk {'printf ("%s host.docker.internal\n", $3)'} >> /etc/hosts ;\
  java -Dspring.config.location=./config/application.properties \
  -DFATE_DEPLOY_PREFIX=/app/fatelogs/ \
  -Dssh_config_file=ssh \
  -Xmx2048m -Xms2048m -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:logs/gc.log -XX:+HeapDumpOnOutOfMemoryError \
  -jar fateboard.jar
