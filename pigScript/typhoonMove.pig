-- データを読み込む
typhoon_input = LOAD 'data/input/'USING PigStorage( ',' ) AS (year:int, month:int, day:int, time:int,num:int, name:chararray,level:int, lat:double, log:double,power:double,wind:double,area_1:double,area_2:double,area_3:double,area_4:double,area_5:double,area_6:double,toggle:int );

--データを月、日、時でソート
order_data = ORDER typhoon_input BY year,month,day,time ;
--ソートしたデータを名称ごとグループ化
typhoon_data_all = Group order_data BY num;

-- 一番気圧が低下した時のデータ、各台風のデータ数を記録
hpower_data = FOREACH typhoon_data_all {sorted = ORDER order_data BY power; mdata = LIMIT sorted 1; GENERATE group , FLATTEN(mdata.power) AS power ,FLATTEN(mdata.lat) AS lat , FLATTEN(mdata.log) AS log , COUNT(order_data),FLATTEN(mdata.year) AS year,FLATTEN(mdata.month) AS month,FLATTEN(mdata.day) AS day,FLATTEN(mdata.time) AS time;};

-- outputデータを削除
rmf data/output/high;
-- 取得したデータをoutput
;STORE hpower_data INTO 'data/output/high' USING PigStorage(',');