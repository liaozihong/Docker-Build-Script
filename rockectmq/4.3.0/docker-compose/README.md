# install
### in 4.3.0 folder run

1. build docker images

```
./play-docker-compose.sh
```

2. setup your broker ip in data/broker/conf/broker.properties

3. run docker-compose

```
docker-compose -f docker-compose/docker-compose.yml up
```


# How it work

1. modify rocketmq-broker/Dockerfile change last line as bellow

```
&& sh mqbroker -n namesrv:9876  -c /opt/conf/broker.properties
```

2. create data folders and setup broker.properties
./data/broker/conf/broker.properties

```
set brokerIP1=yourip_in_here
```

3. modify volumes in docker-compose.yml 

```
    volumes:
      - ./data/broker/logs:/opt/logs
      - ./data/broker/store:/opt/store
      - ./data/broker/conf:/opt/conf
```

4. add rocketmq-console-ng in docker-compose.yml 

