### Docker-Build-Script 
#### 简介
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

目录描述：  

* **DubboAdmin-docker**  	：  使用docker定制 dubbo的可视化管理界面
* **Huginn**		     	：  个性定制行为的工具
* **Memcached-docker** 		：  缓存中间件
* **alibaba-sentinel**  	：	阿里巴巴的开源服务监控平台
* **confluence**			：  办公流程工具搭建
* **docker-elk** 		  	：	基于Elasticsearch的日志采集系统  
* **docker_Kafka** 		  	：	Kafka消息中间件搭建
* **fastDfs-docker** 	  	：	分布式文件系统搭建
* **jdk-graphicsmagick**  	：	jdk镜像默认安装图片处理工具
* **mysql-master-slave**  	：	mysql主从复制环境搭建
* **mysql** 			  	：	Mysql数据库搭建
* **nexus**				  	：	maven私服搭建
* **nginx**				  	：	nginx服务器搭建
* **nsq-docker** 		  	：	一个由go实现的分布式消息中间件搭建
* **redis-sentinel-noauth** ：  redis的无授权配置哨兵搭建示例
* **redis-sentine**l	  	：	redis的哨兵模式搭建示例
* **redis** 			  	：	redis缓存数据库搭建
* **rocketmq** 			  	：	阿里巴巴消息中间件搭建
* **sonarqube** 		  	：	代码审计平台搭建
* **workpress**	  	        ：  博客系统搭建
* **skywalking**            :   分布式跟踪系统
 

GitHub:  
https://github.com/liaozihong/Docker-Build-Script  

**有问题欢迎指出!**