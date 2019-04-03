ARG ELK_VERSION

# https://github.com/elastic/elasticsearch-docker
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:${ELK_VERSION}

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install zip
RUN mkdir -p /usr/share/elasticsearch/plugins/ik
RUN cd /usr/share/elasticsearch/plugins/ik && 
    wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.0/elasticsearch-analysis-ik-5.5.0.zip && 
	unzip elasticsearch-analysis-ik-5.5.0.zip
	
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.0/elasticsearch-analysis-ik-5.5.0.zip  
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v5.5.0/elasticsearch-analysis-pinyin-5.5.0.zip