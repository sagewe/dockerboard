# FATE on Docker

使用docker快速部署 FATE Board 的单机实验环境

# 快速开始

启动服务

``` sh
docker run -d --name dockerboard -p <port>:8080 -v <fate_sqlite.db>:/app/sqlite.db -v <fate log>:/app/fatelogs sagewei0/dockerboard
```

