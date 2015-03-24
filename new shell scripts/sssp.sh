#Revision March 19, 2015 (XL)   

#Confirm HADOOP_HOME & GIRAPH_HOME
export HADOOP_HOME=/usr/local/hadoop
export GIRAPH_HOME=/usr/local/giraph

#Copy SSSP Src to Giraph Sample Library
cp sssp.java /usr/local/giraph/giraph-examples/src/main/java/org/apache/giraph/examples  

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
cp sssp.txt /tmp

#Put input into HDFS
$HADOOP_HOME/bin/hadoop dfs -copyFromLocal /tmp/sssp.txt /input/sssp.txt                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                            
#Run SSSP algorithm using Hadoop giraph                                                                                                                                                                                                                                                                                                                                                                                   
$HADOOP_HOME/bin/hadoop jar $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.1.0-for-hadoop-1.2.1-jar-with-dependencies.jar org.apache.giraph.GiraphRunner org.apache.giraph.examples.sssp -vif org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat -vip /input/sssp.txt -vof org.apache.giraph.io.formats.IdWithValueTextOutputFormat -op /output/shortestpaths -w 1
                                                                                                                                                                                                                                                                                                                                                                                                                            
#retreive results from hdfs                                                                                                                                                                                                                                                                                                                                                                                                 
$HADOOP_HOME/bin/hadoop dfs -cat /output/shortestpaths/p*
#---------------------------------------------

                                                                                                                                                                                                                                                                                                                                                               