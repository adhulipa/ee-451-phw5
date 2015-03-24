cp /vagrant/.vagrant/machines/default/virtualbox/private_key ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
export HADOOP_HOME=/usr/local/hadoop
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
echo "export HADOOP_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> ~/.bashrc
export GIRAPH_HOME=/usr/local/giraph
echo "export GIRAPH_HOME=/usr/local/giraph" >>~/.bashrc
source ~/.bashrc
$HADOOP_HOME/bin/hadoop namenode -format
$HADOOP_HOME/bin/start-dfs.sh
$HADOOP_HOME/bin/start-mapred.sh

sudo apt-get install git
sudo apt-get install maven
mvn -version
cd /usr/local/
sudo git clone https://github.com/apache/giraph.git
sudo chown -R vagrant giraph
export GIRAPH_HOME=/usr/local/giraph
source $HOME/.bashrc
cd $GIRAPH_HOME
mvn -e package -Phadoop_0.20.203 -DskipTests
