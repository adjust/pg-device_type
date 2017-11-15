
DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
	EXECUTE $E$ ALTER FUNCTION device_type_in(cstring) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_out(device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_recv(internal) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_send(device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_eq(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_ne(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_lt(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_le(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_gt(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_ge(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION device_type_cmp(device_type, device_type) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION hash_device_type(device_type) PARALLEL SAFE $E$;
  END IF;
END;
$$;

