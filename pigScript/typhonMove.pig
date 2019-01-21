typhon_input = LOAD 'data/input/'USING PigStorage( ',' ) AS (year:int, month:int, day:int, time:int,power:double, name:chararray,level:int, row:double, col:double );

typhon_data_all = Group typhon_input BY name;


DUMP typhon_data_all;
