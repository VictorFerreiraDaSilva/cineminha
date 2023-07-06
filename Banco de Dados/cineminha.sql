DROP SCHEMA IF EXISTS cineminhas;
CREATE SCHEMA cineminhas;
USE cineminhas;

DROP TABLE IF EXISTS tipo_funcionario;
CREATE TABLE tipo_funcionario(
	cd_tipo_funcionario INT,
	nm_tipo_funcionario VARCHAR(255),
	CONSTRAINT pk_tipo_funcionario PRIMARY KEY (cd_tipo_funcionario)
);