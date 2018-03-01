#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && pwd)

# remove old output
hadoop fs -rm -r -f /ncdcjob-output-python

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar  \
-files $BASEDIR/src/main/python/ncdc-mapper.py,$BASEDIR/src/main/python/ncdc-reducer.py \
-input /ncdc \
-output /ncdcjob-output-python \
-mapper $BASEDIR/src/main/python/ncdc-mapper.py \
-reducer $BASEDIR/src/main/python/ncdc-reducer.py
