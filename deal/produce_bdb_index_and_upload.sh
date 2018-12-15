#! /bin/bash

source ../config/set_env.sh

db_name=wangliming
jar_path="/home/wangliming/big_data_search_w/udf/TlHadoopCore-jar-with-dependencies.jar"
class_path="cn.tledu.drivers.DataDistributeBDBDriver"
input_path=/apps/hive/warehouse/wangliming.db/weibo_json/week_seq=week1
output_path=/tmp/wangliming/bdboutput1
yarn jar $jar_path $class_path -Dmapred.reduce.tasks=0 $input_path $output_path
hdfs dfs -rm -r $output_path"/par*"
