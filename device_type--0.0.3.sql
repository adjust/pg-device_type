CREATE FUNCTION device_type_in(cstring)
RETURNS device_type
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION device_type_out(device_type)
RETURNS cstring
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION device_type_recv(internal)
RETURNS device_type
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION device_type_send(device_type)
RETURNS bytea
AS '$libdir/device_type'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE device_type (
	INPUT          = device_type_in,
	OUTPUT         = device_type_out,
	RECEIVE        = device_type_recv,
	SEND           = device_type_send,
	LIKE           = "char",
	CATEGORY       = 'S'
);
COMMENT ON TYPE device_type IS 'a device_type internaly stored as uint8';

CREATE FUNCTION device_type_eq(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_ne(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_lt(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_le(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_gt(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_ge(device_type, device_type)
RETURNS boolean LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION device_type_cmp(device_type, device_type)
RETURNS integer LANGUAGE C IMMUTABLE AS '$libdir/device_type';

CREATE FUNCTION hash_device_type(device_type)
RETURNS integer LANGUAGE C IMMUTABLE AS '$libdir/device_type';

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
	ALTER FUNCTION device_type_in(cstring) PARALLEL SAFE;
	ALTER FUNCTION device_type_out(device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_recv(internal) PARALLEL SAFE;
	ALTER FUNCTION device_type_send(device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_eq(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_ne(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_lt(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_le(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_gt(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_ge(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION device_type_cmp(device_type, device_type) PARALLEL SAFE;
	ALTER FUNCTION hash_device_type(device_type) PARALLEL SAFE;
    ALTER FUNCTION int4_to_device_type(int4) PARALLEL SAFE;
    ALTER FUNCTION device_type_to_int4(device_type) PARALLEL SAFE;
    ALTER FUNCTION int2_to_device_type(int2) PARALLEL SAFE;
    ALTER FUNCTION device_type_to_int2(device_type) PARALLEL SAFE;
  END IF;
END;
$$;

CREATE OPERATOR = (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_eq,
	COMMUTATOR = '=',
	NEGATOR = '<>',
	RESTRICT = eqsel,
	JOIN = eqjoinsel
);
COMMENT ON OPERATOR =(device_type, device_type) IS 'equals?';

CREATE OPERATOR <> (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_ne,
	COMMUTATOR = '<>',
	NEGATOR = '=',
	RESTRICT = neqsel,
	JOIN = neqjoinsel
);
COMMENT ON OPERATOR <>(device_type, device_type) IS 'not equals?';

CREATE OPERATOR < (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_lt,
	COMMUTATOR = > ,
	NEGATOR = >= ,
   	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <(device_type, device_type) IS 'less-than';

CREATE OPERATOR <= (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_le,
	COMMUTATOR = >= ,
	NEGATOR = > ,
   	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <=(device_type, device_type) IS 'less-than-or-equal';

CREATE OPERATOR > (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_gt,
	COMMUTATOR = < ,
	NEGATOR = <= ,
   	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >(device_type, device_type) IS 'greater-than';

CREATE OPERATOR >= (
	LEFTARG = device_type,
	RIGHTARG = device_type,
	PROCEDURE = device_type_ge,
	COMMUTATOR = <= ,
	NEGATOR = < ,
   	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >=(device_type, device_type) IS 'greater-than-or-equal';

CREATE OPERATOR CLASS btree_device_type_ops
DEFAULT FOR TYPE device_type USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       device_type_cmp(device_type, device_type);

CREATE OPERATOR CLASS hash_device_type_ops
    DEFAULT FOR TYPE device_type USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_device_type(device_type);

CREATE CAST (int4 as device_type)
WITH FUNCTION int4_to_device_type(int4);

CREATE CAST (device_type as int4)
WITH FUNCTION device_type_to_int4(device_type);

CREATE CAST (int2 as device_type)
WITH FUNCTION int2_to_device_type(int2);

CREATE CAST (device_type as int2)
WITH FUNCTION device_type_to_int2(device_type);
