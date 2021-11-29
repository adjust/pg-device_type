CREATE FUNCTION int4_to_device_type(int4)
RETURNS device_type
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION device_type_to_int4(device_type)
RETURNS int4
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION int2_to_device_type(int2)
RETURNS device_type
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION device_type_to_int2(device_type)
RETURNS int2
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
    ALTER FUNCTION int4_to_device_type(int4) PARALLEL SAFE;
    ALTER FUNCTION device_type_to_int4(device_type) PARALLEL SAFE;
    ALTER FUNCTION int2_to_device_type(int2) PARALLEL SAFE;
    ALTER FUNCTION device_type_to_int2(device_type) PARALLEL SAFE;
  END IF;
END;
$$;

CREATE CAST (int4 as device_type)
WITH FUNCTION int4_to_device_type(int4);

CREATE CAST (device_type as int4)
WITH FUNCTION device_type_to_int4(device_type);

CREATE CAST (int2 as device_type)
WITH FUNCTION int2_to_device_type(int2);

CREATE CAST (device_type as int2)
WITH FUNCTION device_type_to_int2(device_type);
