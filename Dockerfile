# Stage 1: Build
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy only this module
COPY pom.xml .
COPY src ./src

# Build the module
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built jar
COPY --from=builder /app/target/*.jar app.jar

# Run
ENTRYPOINT ["java","-jar","/app/app.jar"]
