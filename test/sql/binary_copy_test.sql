BEGIN;
CREATE EXTENSION device_type;
CREATE TABLE before (a device_type);
INSERT INTO before VALUES ('bot'), ('console'), ('ipod'), ('mac'), ('pc'), ('phone'), ('server'), ('simulator'), ('tablet'), ('tv'), ('unknown');
CREATE TABLE after (a device_type);
COPY before TO '/tmp/tst' WITH (FORMAT binary);
COPY after FROM '/tmp/tst' WITH (FORMAT binary);
SELECT * FROM after;
ROLLBACK;
