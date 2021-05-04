FROM java:latest
COPY ./target/ /home/target
COPY ./database_config/ /home/target
WORKDIR /home/target
EXPOSE 80
ENTRYPOINT ["java", "-jar", "spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar", "--server.port=80", "--spring.config.location=/home/target/database_config"]
