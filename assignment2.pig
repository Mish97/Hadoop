ordersCSV = LOAD '/user/maria_dev/orders.csv' USING PigStorage(',')
AS
(game_id:chararray,
 unit_id:chararray,
 unit_order:chararray,
 location:chararray,
 target:chararray,
 target_dest:chararray,
 success:chararray,
 reason:chararray,
 turn_num:chararray);
filteredTarget = FILTER ordersCSV BY target == '"Holland"';
filteredLocation = Filter filteredTarget BY location != '';
by_location = GROUP filteredTarget by (location, target);
by_location_terms_count = FOREACH by_location GENERATE group, COUNT($1);
sorted = Order by_location_terms_count BY $0 ASC; 
DUMP sorted;
