# Use a base image with Java 21 runtime
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the maven wrapper and pom file
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Package the application (and skip tests since they already ran)
RUN ./mvnw package -DskipTests

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "target/github-actions-demo-0.0.1-SNAPSHOT.jar"]