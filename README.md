# Trainings and workshops

Step-by-step guide to install the training platform based on the Elastic Stack.

## Install dependencies - Debian based systems

```
sudo apt-get install openjdk-11-jre curl jq
```

## Download Elastic Stack components

```
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-linux-x86_64.tar.gz 
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.4.0-linux-x86_64.tar.gz 
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.4.0.tar.gz  
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-linux-x86_64.tar.gz 
```

## Install and launch Elasticsearch

```
cd
tar zxvf elasticsearch-7.4.0-linux-x86_64.tar.gz 
./elasticsearch-7.4.0/bin/elasticsearch
```

## Install and launch Kibana

```
cd
tar zxvf kibana-7.4.0-linux-x86_64.tar.gz
./kibana-7.4.0-linux-x86_64/bin/kibana
```

## Install Logstash

```
cd
tar zxvf logstash-7.4.0.tar.gz
```

## Install Filebeat

```
cd
tar zxvf filebeat-7.4.0-linux-x86_64.tar.gz
```


```
cp logstash.conf logstash-X.Y.Z/config/
./logstash-X.Y.Z/bin/logstash -f ./logstash-X.Y.Z/config/logstash.conf
```

## To start filebeat with filebeat.yml:

```
cp filebeat.yml filbeat-X.Y.Z/
./filebeat-X.Y.Z/filebeat --path.config ./filebeat-X.Y.Z
```
