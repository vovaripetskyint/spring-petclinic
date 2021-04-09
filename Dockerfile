FROM java:latest
COPY ./spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar /home/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar
WORKDIR /home
EXPOSE 80
ENTRYPOINT ["java", "-jar", "spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar", "--server.port=80", "--spring.config.location=/home/"]
