# Trainings and workshops

Step-by-step guide to install the training platform based on the Elastic Stack.

## Downloading and installing components

### Install dependencies - Debian based systems

```
sudo apt-get install openjdk-11-jre curl jq liburi-perl
```

### Download Elastic Stack components

```
cd
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz 
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.10.2-linux-x86_64.tar.gz 
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.10.2-linux-x86_64.tar.gz 
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.2-linux-x86_64.tar.gz 
```

### Install and launch Elasticsearch

```
cd
tar zxvf elasticsearch-7.10.2-linux-x86_64.tar.gz 
./elasticsearch-7.10.2/bin/elasticsearch
```

### Install and launch Kibana

```
cd
tar zxvf kibana-7.10.2-linux-x86_64.tar.gz
./kibana-7.10.2-linux-x86_64/bin/kibana
```

### Install Logstash

```
cd
tar zxvf logstash-7.10.2-linux-x86_64.tar.gz
```

### Install Filebeat

```
cd
tar zxvf filebeat-7.10.2-linux-x86_64.tar.gz
```

## Configuring components

### Configuring and starting Logstash

```
cd
wget https://raw.githubusercontent.com/onyphe/training/master/logstash.conf
mv logstash.conf logstash-7.10.2/config/
./logstash-7.10.2/bin/logstash -f ./logstash-7.10.2/config/logstash.conf
```

### Configuring and starting Filebeat

```
cd
wget https://raw.githubusercontent.com/onyphe/training/master/filebeat.yml
mv filebeat.yml filebeat-7.10.2-linux-x86_64/
./filebeat-7.10.2-linux-x86_64/filebeat --path.config ./filebeat-7.10.2-linux-x86_64 &
tail -f filebeat-7.10.2-linux-x86_64/logs/filebeat
```
