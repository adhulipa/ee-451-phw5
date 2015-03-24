#save graph file to hdfs
cp gph.txt /tmp
$HADOOP_HOME/bin/hadoop dfs -copyFromLocal /tmp/gph.txt /input/gph.txt

#run Shortest path algorithm using giraph
$HADOOP_HOME/bin/hadoop jar $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.1.0-for-hadoop-0.20.203.0-jar-with-dependencies.jar org.apache.giraph.GiraphRunner org.apache.giraph.examples.SimpleShortestPathsComputation -vif org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat -vip /input/gph.txt -vof org.apache.giraph.io.formats.IdWithValueTextOutputFormat -op /output/shortestpaths -w 1

#retreive results from hdfs
$HADOOP_HOME/bin/hadoop dfs -cat /output/shortestpaths/p*