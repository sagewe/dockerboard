# clone
FROM alpine/git
WORKDIR /data/app
RUN git clone https://github.com/FederatedAI/FATE-Board.git

# build
FROM maven:3-jdk-8
WORKDIR /data/app
COPY --from=0 /data/app .
RUN mvn clean package -f FATE-Board/pom.xml

# runtime
FROM openjdk:8-jdk
WORKDIR /app
VOLUME /app/logs
VOLUME /app/fatelogs
RUN set -e ;\
    apt-get update ;\
    apt-get install -y iproute2 ;\
    mkdir ssh ;\
    touch ssh/ssh.properties ;\
    mkdir config
COPY application.properties config/
COPY service.sh .
COPY --from=1 /data/app/FATE-Board/target/fateboard-*.jar fateboard.jar
CMD ["sh", "service.sh"] 
