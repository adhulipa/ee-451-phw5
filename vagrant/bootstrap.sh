sudo apt-get -y install openjdk-7-jdk
pushd /usr/local
sudo wget http://archive.apache.org/dist/hadoop/core/hadoop-0.20.203.0/hadoop-0.20.203.0rc1.tar.gz
sudo tar xzf hadoop-0.20.203.0rc1.tar.gz
sudo mv hadoop-0.20.203.0 hadoop
sudo chown -R vagrant:vagrant hadoop
export HADOOP_HOME=/usr/local/hadoop
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
echo "export HADOOP_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> ~/.bashrc
source ~/.bashrc
sudo sh -c 'echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> /usr/local/hadoop/conf/hadoop-env.sh'
sudo sh -c 'echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> /usr/local/hadoop/conf/hadoop-env.sh'
sudo mkdir -p /app/hadoop/tmp
sudo chown -R vagrant:vagrant /app/hadoop/tmp/
popd
sudo cp /vagrant/core-site.xml $HADOOP_HOME/conf/
sudo cp /vagrant/mapred-site.xml $HADOOP_HOME/conf/
sudo cp /vagrant/hdfs-site.xml $HADOOP_HOME/conf/
sudo cp /vagrant/masters $HADOOP_HOME/conf/
sudo cp /vagrant/slaves $HADOOP_HOME/conf/
sudo sh -c 'ifconfig | grep "inet addr:" | cut -f2 -d: | cut -f1 -d" " | xargs -I {} echo {} hdnode01 >> /etc/hosts'

#===giraph
sudo apt-get -y install maven
cd /usr/local
sudo wget http://apache.arvixe.com/giraph/giraph-1.1.0/giraph-dist-1.1.0-src.tar.gz
sudo tar xvzf giraph-dist-1.1.0-src.tar.gz
sudo mv giraph-1.1.0 giraph
sudo chown -R vagrant:vagrant giraph
export GIRAPH_HOME=/usr/local/giraph
echo "export GIRAPH_HOME=/usr/local/giraph" >>~/.bashrc
source ~/.bashrc
pushd $GIRAPH_HOME
mvn package -Phadoop_0.20.203 -DskipTests
popd
