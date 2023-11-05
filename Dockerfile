# Use Maven to build the project
FROM maven:3.6.3-jdk-8 as builder
WORKDIR /app
COPY . /app
RUN mvn clean package

# Setup the runtime environment
FROM openjdk:8-jre
WORKDIR /app
COPY --from=builder /app/target/wowchat-1.3.8.zip /app/
RUN unzip wowchat-1.3.8.zip

# Entry point to run the application
ENTRYPOINT ["java", "-jar", "wowchat.jar"]
CMD ["wowchat.conf"]
