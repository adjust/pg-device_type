#ifndef DEVICE_TYPE_H
#define DEVICE_TYPE_H

#include "postgres.h"
#include "fmgr.h"
#include "libpq/pqformat.h"
#include "access/hash.h"

typedef uint8 device_type;

#define CONST_STRING(s) (sizeof(s)/sizeof(s[0])), s
#define PG_RETURN_UINT8(x) return UInt8GetDatum(x)
#define PG_GETARG_UINT8(x) DatumGetUInt8(PG_GETARG_DATUM(x))


#define BOT        20
#define CONSOLE    40
#define IPOD       80
#define MAC       100
#define PC        120
#define PHONE     140
#define SERVER    160
#define SIMULATOR 180
#define TABLET    200
#define TV        220
#define UNKNOWN   255

Datum device_type_in(PG_FUNCTION_ARGS);
Datum device_type_out(PG_FUNCTION_ARGS);
Datum device_type_recv(PG_FUNCTION_ARGS);
Datum device_type_send(PG_FUNCTION_ARGS);
Datum device_type_eq(PG_FUNCTION_ARGS);
Datum device_type_ne(PG_FUNCTION_ARGS);
Datum device_type_lt(PG_FUNCTION_ARGS);
Datum device_type_le(PG_FUNCTION_ARGS);
Datum device_type_gt(PG_FUNCTION_ARGS);
Datum device_type_ge(PG_FUNCTION_ARGS);
Datum device_type_cmp(PG_FUNCTION_ARGS);
Datum hash_device_type(PG_FUNCTION_ARGS);
#endif // DEVICE_TYPE_H
