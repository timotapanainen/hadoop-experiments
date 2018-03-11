#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && pwd)

# remove old output
hadoop fs -rm -r -f /output/mr-python

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar  \
-files $BASEDIR/mapreduce/src/main/python/ncdc-mapper.py,$BASEDIR/mapreduce/src/main/python/ncdc-reducer.py \
-input /ncdc \
-output /output/mr-python \
-mapper $BASEDIR/mapreduce/src/main/python/ncdc-mapper.py \
-reducer $BASEDIR/mapreduce/src/main/python/ncdc-reducer.py
