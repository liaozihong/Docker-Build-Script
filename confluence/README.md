基于docker 的confluence 安装 和破解
---

####  克隆项目
```
git clone git@github.com:joker8023/confluence.git
```
#### 启动docker-compose
```
sudo docker-compose up -d
```
> 启动页面并记录Service ID

#### 破解confluence
 
 破解文件在crackfile文件夹中
 
#### 复制并备份文件

```
docker cp confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar ~/confluence/crackfile/atlassian-extras-2.4.jar
```
进入容器 并备份文件

 
```

    docker exec -it confluence /bin/sh
mv /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar  /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar.bak
```





#### 使用破解工具生成新的jar文件
    
```
    # linux需要GUI,也可以在windows使用keygen.bat
confluencec/rackfile/iNViSiBLE/keygen.sh
#将一开始记录的Service ID 输入，name可以随意填写
#点击patch选择刚改名的文件点击.gen！生成key，则atlassian-extras-2.4.jar已经破解完成
```



####  将atlassian-extras-2.4.jar改回atlassian-extras-decoder-v2-3.2.jar并复制回原先目录

```
docker cp ~ ~/confluence/crackfile/atlassian-extras-decoder-v2-3.2.jar confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/
```
### 3.4 重启

```
docker stop confluence
docker start confluence
```

