-- データを読み込む
typhon_input = LOAD 'data/input/'USING PigStorage( ',' ) AS (year:int, month:int, day:int, time:int,num:int, name:chararray,level:int, row:double, col:double,power:double );

--データを月、日、時でソート
order_data = ORDER typhon_input BY year,month,day,time ;
-- ソートしたデータを名称ごとグループ化
typhon_data_all = Group order_data BY num;

-- 一番気圧が低下した時のデータ、各台風のデータ数を記録
hpower_data = FOREACH typhon_data_all GENERATE group , MIN(order_data.power), COUNT(order_data);

-- outputデータを削除
rmf data/output;
-- 取得したデータをoutput
;STORE hpower_data INTO 'data/output';