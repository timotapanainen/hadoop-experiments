#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && cd .. && pwd)
OUTPUT_DIR=$BASEDIR/output/ncdcjob-java

export HADOOP_CLASSPATH=$BASEDIR/target/classes

hadoop fi.t12n.hadoop.mapreduce.ncdc.NcdcJob -conf $BASEDIR/configuration/application/hadoop-local.xml $BASEDIR/data/sample.txt $OUTPUT_DIR
