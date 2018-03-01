#!/usr/bin/env bash

BASEDIR=$(cd `dirname $0` && pwd)
export HADOOP_HOME=$BASEDIR/hadoop-2.7.5
export HADOOP_CONF_DIR=$BASEDIR/configuration/local
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home