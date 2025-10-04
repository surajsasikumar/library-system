#  Build
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /library-system
COPY application.yml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /library-system
COPY --from=builder /app/target/*.jar app.jar

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
