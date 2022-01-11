FROM maven:3.5-jdk-11 as buildstage
RUN mkdir /opt/note
WORKDIR /opt/note
RUN git clone https://github.com/callicoder/spring-boot-mysql-rest-api-tutorial.git /opt/note
RUN mvn package -Dmaven.test.skip=true

FROM adoptopenjdk/openjdk11:x86_64-alpine-jdk-11.0.4_11-slim
RUN addgroup -S notes && adduser -S notes -G notes
RUN mkdir /opt/note
RUN chown -R notes:notes /opt/note
USER notes:notes
WORKDIR /opt/note
COPY --from=buildstage /opt/note/target/easy-notes-1.0.0.jar .
COPY application.properties application.properties
ENTRYPOINT ["java", "-jar", "/opt/note/easy-note.jar"]