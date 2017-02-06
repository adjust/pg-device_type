[![Build Status](https://travis-ci.org/adjust/pg-device_type.svg)](https://travis-ci.org/adjust/pg-device_type)

# PG Country

A 1-byte Device type data-type for PostgreSQL. Currently supported DeviceTypes:

    bot
    console
    ipod
    mac
    pc
    phone
    server
    simulator
    tablet
    unknown

### Installation

You can clone the extension and run the standard `make && make install` to
build it against your PostgreSQL server.

### Usage

The following example illustrates the use of the `device_type` type.

```SQL
CREATE TABLE events (id serial, origin device_type);

INSERT INTO events (values
  (1, 'tablet'),
  (2, 'bot'),
  (3, 'tablet')
);

SELECT * FROM events ORDER BY origin;
```

The result from the above execution will be:

```
 id | origin
----+--------
  2 | bot
  1 | tablet
  3 | tablet
(3 rows)
```

### Development

To run the tests, clone and run `make && make install && make installcheck`.
[Dumbo](https://github.com/adjust/dumbo) is the recommended development tool for
the extension.
