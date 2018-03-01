#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && pwd)
# remove old output
hadoop fs -rm -r -f /ncdcjob-output-java
hadoop jar $BASEDIR/target/hadoopexp.jar fi.t12n.hadoop.mapreduce.ncdc.NcdcJob -conf $BASEDIR/configuration/application/hadoop-pseudodist.xml /ncdc /ncdcjob-output-java
