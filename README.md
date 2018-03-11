
Hadoop experiments
==================

This repository contains experiments based on the [Hadoop: The Definitive Guide](http://shop.oreilly.com/product/0636920033448.do) book.

## Hadoop

Following things should be performed in hadoop folder.

### Setup

- Download [Hadoop](http://www.apache.org/dyn/closer.cgi/hadoop/common/) 2.7.5 and extract it into repository root
- Download a weather dataset from the [National Climatic Data Center](ftp://ftp.ncdc.noaa.gov/pub/data/noaa/) 
    ```bash
    # this downloads weather data from 1901 to 1920 but you can change the range 
  	cd data
    ./download_ncdc_data.sh 1901 1920
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


### Start Hadoop daemons

This will start Hadoop in pseudo-distributed mode (single-node).

```bash
# setup HADOOP_HOME, HADOOP_CONF_DIR and PATH environment variables
source hadoop-pseudodist-env.sh

# format namenode
hdfs namenode -format

# start HDFS
start-dfs.sh

# start YARN
start-yarn.sh
```


### Load data into HDFS

```bash
# copy local filesystem files under data/ncdc
hadoop fs -copyFromLocal data/ncdc /ncdc
```

### Run Java MapReduce job

```bash
cd mapreduce
# create jar
mvn package

# run mapreduce job (if it fails, try to run it again)
./run-mr-java-job.sh

# check output
hadoop fs -cat '/output/mr-java/*'
```

You might have to alias hostname to loopback IP address if the job fails due to connection problems. 
1. stop Hadoop daemons (see [Stopping single-node Hadoop] (#stopping-single-node-hadoop))
2. modify /etc/hosts to have something like this "127.0.0.1 localhost ADD_HOSTNAME_HERE" 
3. start Hadoop daemons
4. run the job

### Run Python MapReduce job

```bash

./run-mr-python-job.sh

# check output
hadoop fs -cat '/output/mr-python/*'
```

### Stopping Hadoop daemons

```bash
stop-yarn.sh
stop-dfs.sh
```

## Hive

This example uses Hive to query NCDC data.

### Hive setup:

* [Download Hive 2.3.2](http://www.apache.org/dyn/closer.cgi/hive/)
* Extract to repository root and rename to hive-2.3.2
* Run ```source hive-env.sh```
* Initialize schema by running ```schematool -dbType derby -initSchema```
* Type ```hive``` to run Hive interactive shell
* Execute following SQL-statements to create table and then query max temperature for each year

```sql
CREATE EXTERNAL TABLE ncdc_record (
  var_len STRING, 
  usaf_id STRING, 
  wban_id STRING, 
  measure_date STRING, 
  measure_time STRING, 
  u1 STRING, 
  lat STRING, 
  long STRING, 
  u2 STRING, 
  elev STRING, 
  u3 STRING, 
  u4 STRING, 
  wind_dir STRING, 
  wind_qc STRING, 
  u5 STRING, 
  u6 STRING, 
  u7 STRING, 
  sky_height STRING, 
  sky_height_qc STRING, 
  u8 STRING, 
  u9 STRING, 
  vis_dist STRING, 
  vis_dist_qc STRING, 
  u10 STRING, 
  u11 STRING, 
  air_temp STRING, 
  air_temp_qc STRING, 
  dew_temp STRING, 
  dew_temp_qc STRING, 
  pressure STRING, 
  pressure_qc STRING, 
  rest STRING) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES ("input.regex" = "(.{4})(.{6})(.{5})(.{8})(.{4})(.{1})(.{6})(.{7})(.{5})(.{5})(.{5})(.{4})(.{3})(.{1})(.{1})(.{4})(.{1})(.{5})(.{1})(.{1})(.{1})(.{6})(.{1})(.{1})(.{1})(.{5})(.{1})(.{5})(.{1})(.{5})(.{1})(.*)")
LOCATION '/ncdc/';
```

```sql
select year, max(temp) 
    from (select year(from_unixtime(unix_timestamp(measure_date,'yyyyMMdd'))) as year, 
                 cast(air_temp as int) as temp, 
                 cast(air_temp_qc as int) as temp_qc 
              from ncdc_record) as data
    where temp != 9999 and temp_qc in (0,1,4,5,9) group by year;
```