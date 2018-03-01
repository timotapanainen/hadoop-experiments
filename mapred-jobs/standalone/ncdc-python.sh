#!/usr/bin/env bash

BASEDIR=$(cd `dirname "$0"` && cd .. && cd .. && pwd)
OUTPUT_DIR=$BASEDIR/output/ncdcjob-python

rm -rf $OUTPUT_DIR

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar  \
-files $BASEDIR/src/main/python/ncdc-mapper.py,$BASEDIR/src/main/python/ncdc-reducer.py \
-input $BASEDIR/data/sample.txt \
-output $OUTPUT_DIR \
-mapper $BASEDIR/src/main/python/ncdc-mapper.py \
-reducer $BASEDIR/src/main/python/ncdc-reducer.py