FROM java:latest
COPY ./target/ /home/
WORKDIR /home/target
EXPOSE 80
ENTRYPOINT java -jar *.jar 
