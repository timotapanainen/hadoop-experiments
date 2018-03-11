#!/usr/bin/env bash

BASEDIR=$(cd `dirname $0` && pwd)
export HIVE_HOME=$BASEDIR/hive-2.3.2
export PATH=$PATH:$HIVE_HOME/bin