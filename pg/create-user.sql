CREATE USER odoo14 WITH encrypted PASSWORD 'odoo14' NOSUPERUSER CREATEDB CREATEROLE;
CREATE TABLE hba ( lines text );
COPY hba FROM '/etc/postgresql/12/main/pg_hba.conf';
INSERT INTO hba (lines) VALUES ('host    all             all             0.0.0.0/0               md5');
INSERT INTO hba (lines) VALUES ('host    all             all             ::/0                    md5');
COPY hba TO '/etc/postgresql/12/main/pg_hba.conf';
ALTER SYSTEM SET listen_addresses = '*';
SELECT pg_reload_conf();