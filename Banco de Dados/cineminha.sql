DROP SCHEMA IF EXISTS cineminhas;
CREATE SCHEMA cineminhas;
USE cineminhas;

DROP TABLE IF EXISTS tipo_usuario;
CREATE TABLE tipo_usuario(
	cd_tipo_usuario INT,
	nm_tipo_usuario VARCHAR(255),
	CONSTRAINT pk_tipo_usuario PRIMARY KEY (cd_tipo_usuario)
);

DROP TABLE IF EXISTS genero;
CREATE TABLE genero(
	cd_genero INT,
	nm_genero VARCHAR(255),
    ds_genero TEXT,
	CONSTRAINT pk_genero PRIMARY KEY (cd_genero)
);

DROP TABLE IF EXISTS pessoa;
CREATE TABLE pessoa(
	cd_pessoa INT,
	nm_pessoa VARCHAR(255),
    ds_pessoa TEXT,
	CONSTRAINT pk_pessoa PRIMARY KEY (cd_pessoa)
);

DROP TABLE IF EXISTS dia;
CREATE TABLE dia(
	cd_dia INT,
    nm_dia VARCHAR(20),
    CONSTRAINT pk_dia PRIMARY KEY (cd_dia)
);

DROP TABLE IF EXISTS estado;
CREATE TABLE estado(
	sg_estado CHAR(2),
    nm_estado VARCHAR(20),
    CONSTRAINT pk_estado PRIMARY KEY (sg_estado)
);

DROP TABLE IF EXISTS cidade;
CREATE TABLE cidade(
	cd_cidade INT,
    nm_cidade VARCHAR(255),
    sg_estado CHAR(2),
    CONSTRAINT pk_cidade PRIMARY KEY (cd_cidade),
    CONSTRAINT fk_cidade_estado FOREIGN KEY (sg_estado) REFERENCES estado(sg_estado) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS cinema;
CREATE TABLE cinema(
	cd_cinema INT,
    endereco_cinema VARCHAR(255),
    cd_cidade_cinema INT,
	nm_cinema VARCHAR(255),
    ds_cinema VARCHAR(255),    
	CONSTRAINT pk_cliente PRIMARY KEY (cd_cliente),
    CONSTRAINT fk_cidade_cinema FOREIGN KEY (cd_cidade_cinema) REFERENCES cidade(cd_cidade) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS funcionamento;
CREATE TABLE funcionamento(
	cd_cinema INT,
    cd_dia INT,
    hr_abertura TIME,
    hr_fechamento TIME,
    CONSTRAINT pk_funcionamento PRIMARY KEY (cd_cinema, cd_dia),
    CONSTRAINT fk_funcionamento_cinema FOREIGN KEY (cd_cinema) REFERENCES cinema(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_funcionamento_dia FOREIGN KEY (cd_dia) REFERENCES dia(cd_dia) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
	cpf_usuario CHAR(11),
    rg_usuario CHAR(9),
    email_usuario VARCHAR(255),
    senha_usuario VARCHAR(255),
	nm_usuario VARCHAR(255),
    sobrenome_usuario VARCHAR(255),
    telefone_usuario VARCHAR(15),
    dt_nascimento DATE,
    cd_tipo_usuario INT,
	CONSTRAINT pk_usuario PRIMARY KEY (cpf_usuario),
    CONSTRAINT fk_usuario_tipo FOREIGN KEY (cd_tipo_usuario) REFERENCES tipo_usuario(cd_tipo_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_rg_usuario UNIQUE (rg_usuario),
    CONSTRAINT uq_email_usuario UNIQUE (email_usuario),
    CONSTRAINT uq_telefone_usuario UNIQUE (telefone_usuario)
);

DROP TABLE IF EXISTS funcionario_cinema;
CREATE TABLE funcionario_cinema(
	cpf_funcionario CHAR(11),
    cd_cinema INT,
    CONSTRAINT pk_funcionario_cinema PRIMARY KEY (cpf_funcionario, cd_cinema),
    CONSTRAINT FOREIGN KEY (cpf_funcionario) REFERENCES usuario(cpf_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (cd_cinema) REFERENCES cinema(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS sala;
CREATE TABLE sala(
	cd_cinema INT,
    cd_sala INT,
    qt_poltronas INT,
    qt_fileiras INT,
	CONSTRAINT pk_sala PRIMARY KEY (cd_cinema, cd_sala),
    CONSTRAINT fk_sala_cinema FOREIGN KEY (cd_cinema) REFERENCES cinema(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE
);


