本文使用 Docker 搭建mysql的一主一从集群环境   

关于主从同步的流程图，参考网上找的一张流程图：   
![undefined](http://ww1.sinaimg.cn/large/006mOQRagy1gdmgvwmuehj31010l3jvs.jpg)  

#### 主从模式的优点

1. **负载均衡**:通常情况下，会使用 主服务器 对数据进行 更新、删除 和 新建 等操作，而将 查询 工作落到 从库 头上。    
2. **异地容灾备份**:可以将主服务器上的数据同步到 异地从服务器 上，极大地提高了 数据安全性。  
3. **高可用**:数据库的复制功能实现了 主服务器 与 从服务器间 的数据同步，一旦主服务器出了 故障，从服务器立即担当起主服务器的角色，保障系统持续稳定运作。  
4. **高扩展性**:主从复制 模式支持 2 种扩展方式:  
scale-up  
向上扩展或者 纵向扩展，主要是提供比现在服务器 性能更好 的服务器，比如 增加 CPU 和 内存 以及 磁盘阵列等，因为有多台服务器，所以可扩展性比单台更大。  
scale-out  
向外扩展或者 横向扩展，是指增加 服务器数量 的扩展，这样主要能分散各个服务器的压力。  

#### 主从模式的缺点
1. **成本增加**: 搭建主从肯定会增加成本，毕竟一台服务器和两台服务器的成本完全不同，另外由于主从必须要开启 二进制日志，所以也会造成额外的 性能消耗。  
2. **数据延迟**: 从库 从 主库 复制数据肯定是会有一定的 数据延迟 的。所以当刚插入就出现查询的情况，可能查询不出来。当然如果是插入者自己查询，那么可以直接从 主库 中查询出来，当然这个也是需要用代码来控制的。  
3. **写入更慢**:主从复制 主要是针对 读远大于写 或者对 数据备份实时性 要求较高的系统中。因为 主服务器在写中需要更多操作，而且 只有一台 可以写入的 主库，所以写入的压力并不能被分散。  

#### 主从复制的前提条件
主从服务器 操作系统版本 和 位数 一致。  
主数据库和从数据库的 版本 要一致。   
主数据库和从数据库中的 数据 要一致。  
主数据库 开启 二进制日志，主数据库和从数据库的 server_id 在局域网内必须 唯一。  

#### 搭建集群
本示例使用Mysql 5.7 作为镜像，使用docker-compose进行资源编排。  

首先先对mysql 的master和slave进行配置，创建如下目录问价结构   
D:/docker/mysql-master-slave  
结构树：  
- master
    - data
    - mysqld.conf
- slave
    - data
    - mysqld.conf

接着开始配置master目录底下的mysqld.cnf 文件，内容如下：     
```
[mysqld]
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
datadir     = /var/lib/mysql

#log-error  = /var/log/mysql/error.log

# By default we only accept connections from localhost
#bind-address   = 127.0.0.1

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# 以下是新增内容
# 标识不同的数据库服务器，而且唯一
server-id=1
# 启用二进制日志
log-bin=mysql-bin
log-slave-updates=1
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
skip-host-cache
skip-name-resolve
```

slave 目录底下的mysqld.cnf 内容为：  
```
[mysqld]
pid-file            = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
datadir     = /var/lib/mysql
#log-error  = /var/log/mysql/error.log
# By default we only accept connections from localhost
#bind-address   = 127.0.0.1
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# 以下是新增内容
server-id=2
log-bin=mysql-bin
log-slave-updates=1
# 多主的话需要注意这个配置，防止自增序列冲突。
auto_increment_increment=2
auto_increment_offset=2
read-only=1
slave-skip-errors = 1062
skip-host-cache
skip-name-resolve
```
接着使用docker-compose进行资源编排：  
```
version: '3'
services:
    mysql_master:
        #构建mysql镜像
        image: mysql:5.7
        container_name: mysql_master
        command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci #设置utf8字符集
        restart: always
        environment:
          MYSQL_ROOT_PASSWORD: "root"
          MYSQL_USER: "root"
          MYSQL_PASSWORD: "root"
        ports:
          - '3307:3306' 
        volumes:
            #mysql数据库挂载到host物理机目录/d/docker/mysql/data
          - D:/docker/mysql-master-slave/master/data:/var/lib/mysql
          - D:/docker/mysql-master-slave/master/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf
    
    mysql_slave:
        #构建mysql镜像
        image: mysql:5.7
        container_name: mysql_slave
        command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci #设置utf8字符集
        restart: always
        environment:
          MYSQL_ROOT_PASSWORD: "root"
          MYSQL_USER: "root"
          MYSQL_PASSWORD: "root"
        ports:
          - '3308:3306' 
        volumes:
          - D:/docker/mysql-master-slave/slave/data:/var/lib/mysql
          - D:/docker/mysql-master-slave/slave/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf
```
使用命令docker-compose up -d 启动。  

如果没问题，进入mysql的master配置远程连接，
```
docker exec -it mysql_master bash
# 刚开始默认没密码
mysql

# 支持root用户允许远程连接mysql数据库
mysql> grant all privileges on *.* to 'root'@'%' identified by 'root';
mysql> flush privileges;
退出mysql：
mysql> exit
```
接着，使用数据库连接工具就可以连上了。  

下一步就是进入数据库配置主从配置了，在终端中进入容器：  
```
docker exec -it mysql_master bash
mysql -uroot -p
```
创建一个同步数据权限的用户：  
```
GRANT REPLICATION SLAVE ON *.* to 'backup'@'%' identified by 'root';
```
接着查看状态，记住File、Position的值，在 Slave 中将用到  
```
show master status;
```
![image.png](http://ww1.sinaimg.cn/large/006mOQRagy1gdmh4rj1drj30l50c275r.jpg)   

退出当前容器，进入slave容器  
```
docker exec -it mysql_slave bash
mysql -u root -p
```
设置主库链接,注意master_log_file和master_log_pos要替换成自己相应的master信息,master_host的host可以通过docker inspect 容器id 获得IPAddress
```
change master to master_host='172.17.0.2',master_user='backup',master_password='root',master_log_file='mysql-bin.000003',master_log_pos=439,master_port=3306;
```

最后启动从库同步  
```
start slave
```
查看下状态，如果 Slave_SQL_Running_State 是 Slave has read all relay log; waiting for more updates 表示正常运行。  
```
show slave status \G
```
![image.png](http://ww1.sinaimg.cn/large/006mOQRagy1gdmh994io8j30sl0qfq8s.jpg)  

测试同步，在master上新建一个数据库   
```
docker exec mysql_master mysql -uroot -p -e "CREATE DATABASE test"
docker exec mysql_slave mysql -uroot -p -e "SHOW DATABASES"
```
![image.png](http://ww1.sinaimg.cn/large/006mOQRagy1gdmhabrx0xj30md05fwfm.jpg)

可以看到同步成功了。  

主从同步的简单原理？   
答：   
MySQL的主从复制是一个异步的复制过程，数据库从一个Master复制到Slave数据库，在Master与Slave之间实现整个主从复制的过程是由三个线程参与完成的，其中有两个线程(SQL线程和IO线程)在Slave端，另一个线程(IO线程)在Master端。   
master 数据变化时会产生bin log日志，slave上的线程拉去bin log，然后在slave上重新执行日志。这样就保证了数据一致性。    

show slave status 中的Slave_IO_Running和Slave_SQL_Running的含义？   

答：Slave 上会同时有两个线程在工作， I/O 线程从 Master 得到数据（Binary Log 文件），放到被称为
Relay Log 文件中进行记录。另一方面，SQL 线程则将 Relay Log 读取并执行。   

为什么要有两个线程？这是为了降低同步的延迟。因为 I/O 线程和 SQL 线程都是相对很耗时的操作。   

从服务器同步失败？  
答：看错误日志 tail /var/log/mysql/error.log   
重新执行同步   
stop slave;   
change master to master_log_file='mysql-bin.000100,master_log_pos=123'  
关于 file 和 pos，需在master上执行show master status获得。   
或者使用 mysqlbinlog 命令分析。   

如何添加多个从节点?   
和添加第一个从节点类似，先导出master的数据，复制第一个slave配置文件，唯一要改变的是server-id，不能和其他的重复。之后启动新的容器，进到容器内执行change master to ...。   
还需要注意当前master没有写入等操作，最好先锁表，同步设置好后在解锁。参考   

 
 参考链接：  
[docker学习系列12 轻松实现 mysql 主从同步](https://yq.aliyun.com/articles/681817)   
https://blog.csdn.net/u012562943/article/details/86589834  
