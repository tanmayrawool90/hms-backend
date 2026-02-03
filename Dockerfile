# -------- BUILD STAGE --------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy everything
COPY . .

# Fix mvnw permissions + line endings
RUN chmod +x mvnw && sed -i 's/\r$//' mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# -------- RUN STAGE --------
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=0 /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]