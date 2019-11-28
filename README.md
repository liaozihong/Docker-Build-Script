# Docker-Build-Tools
## 简介
记录基于 docker、docker-compose 快速搭建环境的相关资源  
以下资源是本人在学习相关知识时所总结记录的，已实际使用过，特分享出来。  
为了让开发人员在学习相关内容时，可以基于Docker在本地搭建一套临时环境作为基础，避免因为安装环境而浪费大量时间。  

下列资源提供了相关的docker-compose.yml或Dockerfile,在使用时进入资源文件里，查看是否有需要更换的路径或ip信息，确认完毕后。  
docker-compose.yml 可以使用命令docker-compose up -d 启动安装运行。  
Dockerfile 需要使用命令： 
```
docker build -t imageName:tag .  
```
进行构建镜像,注意不要遗忘了".",接着在使用docker run 命令启动镜像。  

* ELK 			日志系统的创建  
* Memcached 	缓存中间件
* Kafka 		消息中间件
* fastDfs 		分布式文件系统
* mysql 		数据库
* redis 		及redis哨兵模式
* nsq 			消息中间件
* workpress 	博客系统
* confluence 	办公OA系统
* Jdk 			特制附带graphicsmagick软件镜像
* rocketmq 		消息中间件
* sonarqube 	代码审计平台
* nexus 		maven私有库平台
* Huginn		自动化信息平台
* sentinel		阿里巴巴监控平台
