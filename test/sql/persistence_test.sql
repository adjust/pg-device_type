BEGIN;
CREATE EXTENSION device_type;
CREATE TABLE device_type_test AS SELECT 'phone'::device_type, 1 as num;
SELECT * FROM device_type_test;
UPDATE device_type_test SET num = 2;
SELECT * FROM device_type_test;
ROLLBACK;
