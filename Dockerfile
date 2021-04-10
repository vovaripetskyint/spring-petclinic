FROM java:latest
COPY target/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar /home/spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar
WORKDIR /home
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-petclinic-2.2.0.BUILD-SNAPSHOT-master.jar", "--server.port=8080", "--spring.config.location=/home/"]
