FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY . ./
RUN mvn -f pom.xml clean install

FROM openjdk:8
ENV BOOTSTRAP_SERVERS "localhost:9092"
ENV SASL_JAAS_CONFIG  ""
COPY --from=build /app/target/kafka-streams-1.0-SNAPSHOT.jar kafka-streams-1.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/kafka-streams-1.0-SNAPSHOT.jar", "--spring.profiles.active=default"]