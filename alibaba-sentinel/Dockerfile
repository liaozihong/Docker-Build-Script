FROM openjdk:8-jdk-alpine

ADD ./sentinel-dashboard-1.6.3.jar /app.jar
ENTRYPOINT ["java", "-Dserver.port=8080", "-Dcsp.sentinel.dashboard.server=localhost:8080", "-Dproject.name=sentinel-dashboard", "-jar", "/app.jar", "-Dfile.encoding=utf-8"]