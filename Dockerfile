FROM java:latest
COPY ./target/ /home/target
WORKDIR /home/target
EXPOSE 80
ENTRYPOINT java -Dspring.profiles.active=mysql -jar *.jar --server.port=80
