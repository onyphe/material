# training
Material for trainings and workshops

To use this material, you'll have to install the following dependencies:

- Debian systems

sudo apt-get install openjdk-11-jre curl jq

To start logstash with logstash.conf:

cp logstash.conf logstash-X.Y.Z/config
./logstash-X.Y.Z/bin/logstash -f ./logstash-X.Y.Z/config/logstash.conf

To start filebeat with filebeat.yml:

cp filebeat.yml filbeat-X.Y.Z/
./filebeat-X.Y.Z/filebeat --path.config ./filebeat-X.Y.Z
