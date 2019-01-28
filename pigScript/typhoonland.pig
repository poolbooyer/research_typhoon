-- データを読み込む
typhoon_input = LOAD 'data/input/'USING PigStorage( ',' ) AS (year:int, month:int, day:int, time:int,num:int, name:chararray,level:int, lat:double, log:double,power:double,wind:double,area_1:double,area_2:double,area_3:double,area_4:double,area_5:double,area_6:double,toggle:int );

--データを月、日、時でソート
order_data = ORDER typhoon_input BY year,month,day,time ;
filter_data = FILTER order_data BY toggle==1;
group_data = GROUP filter_data BY num;
hoge = FOREACH group_data {GENERATE group, FLATTEN(filter_data.power) AS power ,FLATTEN(filter_data.lat) AS lat , FLATTEN(filter_data.log) AS log ,FLATTEN(filter_data.num) AS year,FLATTEN(filter_data.month) AS month,FLATTEN(filter_data.day) AS day,FLATTEN(filter_data.time) AS time;};
--DUMP hoge;
-- outputデータを削除
rmf data/output/land;
-- 取得したデータをoutput
;STORE hoge INTO 'data/output/land' USING PigStorage(',');