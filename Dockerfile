# Use Maven image for building the application
FROM maven:3.8.3-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project file
COPY pom.xml .

# Download the dependencies specified in the pom.xml
RUN mvn dependency:go-offline

# Copy the entire project's source code
COPY src src

# Build the application
RUN mvn package -DskipTests

# Use AdoptOpenJDK 11 as base image for the runtime environment
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file from the build environment to the runtime environment
COPY --from=builder /app/target/my-spring-boot-app.jar /app/my-spring-boot-app.jar

# Expose the port the Spring Boot application runs on
EXPOSE 8080

# Specify the command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "my-spring-boot-app.jar"]

