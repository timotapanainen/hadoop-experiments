
Hadoop experiments
==================

This repository contains experiments based on the [Hadoop: The Definitive Guide](http://shop.oreilly.com/product/0636920033448.do) book.

Prerequisites
-------------

- Download [Hadoop](http://www.apache.org/dyn/closer.cgi/hadoop/common/) 2.7.5 and extract it into repository root
- Download a weather dataset from the [National Climatic Data Center](ftp://ftp.ncdc.noaa.gov/pub/data/noaa/) 
    ```bash
    # this downloads weather data from 1901 to 1920 but you can change the range  
    ./data/ncdc.sh 1901 1920
    ```
- Install Java and set JAVA_HOME (Java 7 is recommended, you can use [skdman](http://sdkman.io/index.html) to manage Java version)
- Allow SSH access to localhost, single-node Hadoop setup is created by control scripts which require ssh access to localhost
    ```bash
    # generate default ssh identity (id_rsa) if not already done
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
    
    # allow default identity to access localhost 
    cat ~/.ssh/rsa_id.pub >> ~/.ssh/authorized_keys
  
    # test that following works:
    ssh localhost
    ``` 
- If you are using Mac OS, then apply this change to Hadoop configuration [fix](https://stackoverflow.com/a/36269637)


Start Hadoop daemons
--------------------

This will start Hadoop in pseudo-distributed mode (single-node).

```bash
# setup HADOOP_HOME, HADOOP_CONF_DIR and PATH environment variables
source single-node-env.sh

# format namenode
hdfs namenode -format

# start hdfs
start-dfs.sh

# start yarn
start-yarn.sh
```


Load data into HDFS
-------------------

```bash
# copy local filesystem files under data/ncdc
hadoop fs -copyFromLocal data/ncdc /ncdc
```

Run Java MapReduce job
-----------------

```bash
# create jar
mvn package

# run mapreduce job
./mapred-jobs/ncdc-java.sh
```

You might have to alias hostname to loopback IP address if the job fails due to connection problems. 
1. stop Hadoop daemons (see [Stopping single-node Hadoop] (#stopping-single-node-hadoop))
2. modify /etc/hosts to have something like this "127.0.0.1 localhost ADD_HOSTNAME_HERE" 
3. start Hadoop daemons
4. run the job

Run Python MapReduce job
------------------------

```bash
./mapred-jobs/ncdc-python.sh
```

Stopping Hadoop daemons
-----------------------

```bash
stop-yarn.sh
stop-dfs.sh
```




