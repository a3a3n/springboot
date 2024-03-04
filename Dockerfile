# Use AdoptOpenJDK 11 as base image for building the application
FROM adoptopenjdk:11-jdk-hotspot AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle files
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .

# Copy the entire project's source code
COPY src src

# Build the application
RUN chmod +x gradlew
RUN ./gradlew build -x test

# Use AdoptOpenJDK 11 as base image for the runtime environment
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file from the build environment to the runtime environment
COPY --from=builder /app/build/libs/my-spring-boot-app.jar /app/my-spring-boot-app.jar

# Expose the port the Spring Boot application runs on
EXPOSE 8080

# Specify the command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "my-spring-boot-app.jar"]
