FROM openjdk:8-alpine3.8
LABEL maintainer="LiaoDashuai"
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
# 中国特色社会主义
RUN echo https://mirrors.ustc.edu.cn/alpine/v3.8/main > /etc/apk/repositories; \
    echo https://mirrors.ustc.edu.cn/alpine/v3.8/community >> /etc/apk/repositories;\
    echo "Asia/Shanghai" > /etc/timezone ;\
    apk add --no-cache bash curl graphicsmagick &&\
    chmod 777 /usr/local/bin/wait-for-it.sh 
ENTRYPOINT ["sh"]