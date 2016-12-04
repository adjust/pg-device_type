#include "device_type.h"
PG_MODULE_MAGIC;

static inline
char * create_string (size_t size, const char *instr)
{
    char *str = palloc0(size);
    memcpy(str, instr, size);
    return str;
}

static inline
char *device_type_to_str(device_type c)
{
	switch (c)
  {
      case BOT: return create_string(CONST_STRING("bot"));
      case CONSOLE: return create_string(CONST_STRING("console"));
      case IPOD: return create_string(CONST_STRING("ipod"));
      case MAC: return create_string(CONST_STRING("mac"));
      case PC: return create_string(CONST_STRING("pc"));
      case PHONE: return create_string(CONST_STRING("phone"));
      case SERVER: return create_string(CONST_STRING("server"));
      case SIMULATOR: return create_string(CONST_STRING("simulator"));
      case TABLET: return create_string(CONST_STRING("tablet"));
      case TV: return create_string(CONST_STRING("tv"));
      case UNKNOWN: return create_string(CONST_STRING("unknown"));
      default: elog(ERROR, "internal error unexpected num %d in device_type_to_str", c);
  }
}

static inline uint8
check_device_type_num(const char *str, const char *expected, device_type dt)
{
    if (strcmp(expected, str) != 0)
        return 0;

    return dt;
}

static inline uint8
get_device_type_num_p(const char *str)
{
    switch (str[1]) {
        case 'c': return check_device_type_num(str, "pc", PC);
        case 'h': return check_device_type_num(str, "phone", PHONE);
        default : return 0;
    }
}

static inline uint8
get_device_type_num_s(const char *str)
{
    switch (str[1]) {
      case 'e': return check_device_type_num(str, "server", SERVER);
      case 'i': return check_device_type_num(str, "simulator", SIMULATOR);
      default : return 0;
    }
}
static inline uint8
get_device_type_num_t(const char *str)
{
    switch (str[1]) {
      case 'v': return check_device_type_num(str, "tv", TV);
      case 'a': return check_device_type_num(str, "tablet", TABLET);
      default : return 0;
    }
}


static inline
device_type device_type_from_str(const char *str)
{
	if (strlen(str) < 2)
		elog(ERROR, "unknown input device_type: %s", str);

	switch (str[0])
	{
		case 'b': return check_device_type_num(str, "bot", BOT);
		case 'c': return check_device_type_num(str, "console", CONSOLE);
		case 'i': return check_device_type_num(str, "ipod", IPOD);
		case 'm': return check_device_type_num(str, "mac", MAC);
    case 'p': return get_device_type_num_p(str);
    case 's': return get_device_type_num_s(str);
    case 't': return get_device_type_num_t(str);
    case 'u': return check_device_type_num(str, "unknown", UNKNOWN);
	}

  elog(ERROR, "unknown input device_type: %s", str);

	return 0; //keep compiler quiet//
}


PG_FUNCTION_INFO_V1(device_type_in);
Datum
device_type_in(PG_FUNCTION_ARGS)
{
	int i;
	char *str = PG_GETARG_CSTRING(0);
	for(i = 0; str[i]; i++){
  	str[i] = tolower(str[i]);
	}
	PG_RETURN_UINT8(device_type_from_str(str));
}

PG_FUNCTION_INFO_V1(device_type_out);
Datum
device_type_out(PG_FUNCTION_ARGS)
{
	device_type c = PG_GETARG_UINT8(0);
	PG_RETURN_CSTRING(device_type_to_str(c));
}

PG_FUNCTION_INFO_V1(device_type_recv);
Datum
device_type_recv(PG_FUNCTION_ARGS)
{
	StringInfo	buf = (StringInfo) PG_GETARG_POINTER(0);

	PG_RETURN_UINT8(pq_getmsgbyte(buf));

}

PG_FUNCTION_INFO_V1(device_type_send);
Datum
device_type_send(PG_FUNCTION_ARGS)
{
	device_type c = PG_GETARG_UINT8(0);
	StringInfoData buf;

	pq_begintypsend(&buf);
	pq_sendbyte(&buf, c);

	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

PG_FUNCTION_INFO_V1(device_type_eq);
Datum
device_type_eq(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 == arg2);
}

PG_FUNCTION_INFO_V1(device_type_ne);
Datum
device_type_ne(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 != arg2);
}

PG_FUNCTION_INFO_V1(device_type_lt);
Datum
device_type_lt(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 < arg2);
}

PG_FUNCTION_INFO_V1(device_type_le);
Datum
device_type_le(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 <= arg2);
}

PG_FUNCTION_INFO_V1(device_type_gt);
Datum
device_type_gt(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 > arg2);
}

PG_FUNCTION_INFO_V1(device_type_ge);
Datum
device_type_ge(PG_FUNCTION_ARGS)
{
  device_type    arg1 = PG_GETARG_UINT8(0);
  device_type    arg2 = PG_GETARG_UINT8(1);

  PG_RETURN_BOOL(arg1 >= arg2);
}

PG_FUNCTION_INFO_V1(device_type_cmp);
Datum
device_type_cmp(PG_FUNCTION_ARGS)
{
  device_type a = PG_GETARG_UINT8(0);
  device_type b = PG_GETARG_UINT8(1);

  PG_RETURN_INT32((int32) a - (int32) b);
}

PG_FUNCTION_INFO_V1(hash_device_type);
Datum
hash_device_type(PG_FUNCTION_ARGS)
{
  return hash_uint32((int32) PG_GETARG_UINT8(0));
}
