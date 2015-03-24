export HADOOP_HOME=/usr/local/hadoop

export GIRAPH_HOME=/usr/local/giraph

cp pagerank.java /usr/local/giraph/giraph-examples/src/main/java/org/apache/giraph/examples  

cd $GIRAPH_HOME

mvn package -Phadoop_0.20.203 -DskipTests   

cd /vagrant

$HADOOP_HOME/bin/hadoop dfs -rmr /input 
$HADOOP_HOME/bin/hadoop dfs -rmr /output 

cp pagerank.txt /tmp

$HADOOP_HOME/bin/hadoop dfs -copyFromLocal /tmp/pagerank.txt /input/pagerank.txt                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                            
#run Shortest path algorithm using giraph                                                                                                                                                                                                                                                                                                                                                                                   
$HADOOP_HOME/bin/hadoop jar $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.1.0-for-hadoop-0.20.203.0-jar-with-dependencies.jar org.apache.giraph.GiraphRunner org.apache.giraph.examples.pagerank -vif org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat -vip /input/pagerank.txt -vof org.apache.giraph.io.formats.IdWithValueTextOutputFormat -op /output/pagerank -w 1
                                                                                                                                                                                                                                                                                                                                                                                                                            
#retreive results from hdfs                                                                                                                                                                                                                                                                                                                                                                                                 
$HADOOP_HOME/bin/hadoop dfs -cat /output/pagerank/p*                                                                                                                                                                                                                                                                                                                                                                   
