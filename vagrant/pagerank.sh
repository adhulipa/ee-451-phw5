#Revision March 19, 2015 (XL)   

#Confirm HADOOP_HOME & GIRAPH_HOME
export HADOOP_HOME=/usr/local/hadoop
export GIRAPH_HOME=/usr/local/giraph

#Copy PageRank Src to Giraph Sample Library
cp pagerank.java /usr/local/giraph/giraph-examples/src/main/java/org/apache/giraph/examples  

#Compile Source code
cd $GIRAPH_HOME
sudo mvn compile

#Start Job
#--------------------------------------------
#Clean Old files   
cd /vagrant
$HADOOP_HOME/bin/hadoop dfs -rmr /input 
$HADOOP_HOME/bin/hadoop dfs -rmr /output 

#Copy Input File to a temp folder
cp pagerank.txt /tmp

#Put input into HDFS
$HADOOP_HOME/bin/hadoop dfs -copyFromLocal /tmp/pagerank.txt /input/pagerank.txt                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                            
#Run PageRank algorithm using Hadoop giraph                                                                                                                                                                                                                                                                                                                                                                                   
$HADOOP_HOME/bin/hadoop jar $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.1.0-for-hadoop-1.2.1-jar-with-dependencies.jar  org.apache.giraph.GiraphRunner org.apache.giraph.examples.pagerank -vif org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat -vip /input/pagerank.txt -vof org.apache.giraph.io.formats.IdWithValueTextOutputFormat -op /output/pagerank -w 1
                                                                                                                                                                                                                                                                                                                                                                                                                            
#retreive results from hdfs                                                                                                                                                                                                                                                                                                                                                                                                 
$HADOOP_HOME/bin/hadoop dfs -cat /output/pagerank/p* 
#---------------------------------------------

                                                                                                                                                                                                                                                                                                                                                               
