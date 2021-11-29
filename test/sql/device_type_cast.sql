BEGIN;
CREATE EXTENSION device_type;
SELECT 'server'::device_type::int4;
SELECT 'server'::device_type::int2;
SELECT 160::int4::device_type;
SELECT 160::int2::device_type;
ROLLBACK;
