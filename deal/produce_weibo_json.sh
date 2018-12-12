#! /bin/bash
db_name=wangliming
jar_path=/home/wangliming/big_data_search_w/udf/TlHadoopCore-jar-with-dependencies.jar
class_path="cn.tledu.hive.udf.JsonFormatUDF"
from_table=weibo_product
to_table=weibo_json
hive -e "
    set hive.exec.compress.output=true;
    set hive.exec.dynamic.partition.mode=nonstrict;
    set mapred.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec;
    set hive.mapred.partitioner=cn.tledu.hive.partitioner.TianLiangHivePartitioner;
    set mapred.reduce.tasks=50; --设定reduce个数，保证索引和查询的时候数据块的个数一致
    use $db_name;
    add jar $jar_path;
    create temporary function json_format as '$class_path';
    from (select * from $from_table where week_seq='week1') temp
insert overwrite table $to_table partition(week_seq)
select mid,json_format(concat_ws('\001','retweeted_status_mid',retweeted_status_mid,'uid',uid,'retweeted_uid',retweeted_uid,'source',source,'image',image,'text',text,'geo',geo,'created_at',created_at)),week_seq where mid is not null distribute by mid;
"
