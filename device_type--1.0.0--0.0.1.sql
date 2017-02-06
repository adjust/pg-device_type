----functions----
CREATE OR REPLACE FUNCTION device_type_cmp(device_type, device_type)
 RETURNS integer
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_cmp$function$;
----
CREATE OR REPLACE FUNCTION device_type_ge(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_ge$function$;
----
CREATE OR REPLACE FUNCTION device_type_gt(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_gt$function$;
----
CREATE OR REPLACE FUNCTION device_type_le(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_le$function$;
----
CREATE OR REPLACE FUNCTION device_type_lt(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_lt$function$;
----
CREATE OR REPLACE FUNCTION device_type_ne(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_ne$function$;
----
CREATE OR REPLACE FUNCTION device_type_eq(device_type, device_type)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$device_type_eq$function$;
----
CREATE OR REPLACE FUNCTION device_type_send(device_type)
 RETURNS bytea
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/device_type', $function$device_type_send$function$;
----
CREATE OR REPLACE FUNCTION device_type_recv(internal)
 RETURNS device_type
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/device_type', $function$device_type_recv$function$;
----
CREATE OR REPLACE FUNCTION device_type_out(device_type)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/device_type', $function$device_type_out$function$;
----
CREATE OR REPLACE FUNCTION device_type_in(cstring)
 RETURNS device_type
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/device_type', $function$device_type_in$function$;
----
CREATE OR REPLACE FUNCTION hash_device_type(device_type)
 RETURNS integer
 LANGUAGE c
 IMMUTABLE
AS '$libdir/device_type', $function$hash_device_type$function$;
