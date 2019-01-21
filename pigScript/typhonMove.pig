-- データを読み込む
typhon_input = LOAD 'data/input/'USING PigStorage( ',' ) AS (year:int, month:int, day:int, time:int,num:int, name:chararray,level:int, row:double, col:double,power:double );

--データを月、日、時でソート
order_data = ORDER typhon_input BY month,day,time ;
-- ソートしたデータを名称ごとグループ化
typhon_data_all = Group order_data BY name;
DUMP typhon_data_all;