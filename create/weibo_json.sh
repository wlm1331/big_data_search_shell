#! /bin/bash/

#让环境变量生效
source ../config/set_env.sh

#在脚本头部，定义脚本的输入
db_name=wangliming
db_table=weibo_json

$HIVE -e "
  use $db_name;
  CREATE TABLE $db_table(
  mid string,
  result string
)
comment 'weibo json table'
partitioned by (week_seq string comment 'the week sequence')
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' LINES TERMINATED BY '\n'
STORED AS textfile;
"

