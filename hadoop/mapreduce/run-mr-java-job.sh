#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && pwd)
# remove old output
hadoop fs -rm -r -f /output/mr-java
hadoop jar $BASEDIR/mapreduce/target/hadoopexp.jar fi.t12n.hadoop.mapreduce.ncdc.NcdcJob -conf $BASEDIR/conf/client/hadoop-pseudodist.xml /ncdc /output/mr-java
