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

DROP TABLE IF EXISTS caracteristica;
CREATE TABLE caracteristica(
	cd_caracteristica INT,
    nm_caracteristica VARCHAR(255),
    CONSTRAINT pk_caracteristica PRIMARY KEY (cd_caracteristica)
);

DROP TABLE IF EXISTS caracteristica_sala;
CREATE TABLE caracteristica_sala(
	cd_caracteristica INT,
    cd_cinema INT,
    cd_sala INT,
    CONSTRAINT pk_caracteristica_sala PRIMARY KEY (cd_caracteristica, cd_cinema, cd_sala),
    CONSTRAINT fk_cs_caracteristica FOREIGN KEY (cd_caracteristica) REFERENCES caracteristica(cd_caracteristica) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cs_cinema FOREIGN KEY (cd_cinema) REFERENCES sala(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cs_sala FOREIGN KEY (cd_sala) REFERENCES sala(cd_sala) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS filme;
CREATE TABLE filme(
	cd_filme INT,
    nm_filme VARCHAR(255),
    ds_sinopse TEXT,
    dt_lancamento DATE,
    qt_minutos_duracao INT,
    url_trailer VARCHAR(255),
    ds_elenco TEXT,
    ds_direcao TEXT,
    ds_roteiro TEXT,
    ds_producao TEXT,
    CONSTRAINT pk_filme PRIMARY KEY (cd_filme)
);

DROP TABLE IF EXISTS genero_filme;
CREATE TABLE genero_filme(
	cd_filme INT,
    cd_genero INT,
    CONSTRAINT pk_genero_filme PRIMARY KEY (cd_filme, cd_genero),
	CONSTRAINT fk_gf_filme FOREIGN KEY (cd_filme) REFERENCES filme(cd_filme) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_gf_genero FOREIGN KEY (cd_genero) REFERENCES genero(cd_genero) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS sessao;
CREATE TABLE sessao(
	cd_sessao INT,
	cd_filme INT,
    cd_cinema INT,
    cd_sala INT,
    dt_sessao DATE,
    hr_sessao TIME,
    CONSTRAINT pk_sessao PRIMARY KEY (cd_sessao, cd_filme),
    CONSTRAINT fk_sessao_filme FOREIGN KEY (cd_filme) REFERENCES filme(cd_filme) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sessao_cinema FOREIGN KEY (cd_cinema) REFERENCES sala(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sessao_sala FOREIGN KEY (cd_sala) REFERENCES sala(cd_sala) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS poltrona;
CREATE TABLE poltrona(
	cd_poltrona CHAR(4),
	cd_cinema INT,
    cd_sala INT,
    ic_poltrona_deficiente boolean,
    CONSTRAINT pk_poltrona PRIMARY KEY (cd_poltrona, cd_cinema, cd_sala),
    CONSTRAINT fk_poltrona_cinema FOREIGN KEY (cd_cinema) REFERENCES sala(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_poltrona_sala FOREIGN KEY (cd_sala) REFERENCES sala(cd_sala) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS compra;
CREATE TABLE compra(
	cpf_usuario CHAR(11),
    cd_compra INT,
    cd_sessao INT,
	cd_filme INT,
    dt_compra DATE,
    hr_compra TIME,    
    CONSTRAINT pk_compra PRIMARY KEY (cpf_usuario, cd_compra),
    CONSTRAINT fk_compra_usuario FOREIGN KEY (cpf_usuario) REFERENCES usuario(cpf_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_compra_sessao FOREIGN KEY (cd_sessao) REFERENCES sessao(cd_sessao) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_compra_filme FOREIGN KEY (cd_filme) REFERENCES sessao(cd_filme) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS compra_poltrona;
CREATE TABLE compra_poltrona(
	cpf_usuario CHAR(11),
    cd_compra INT,
    cd_poltrona CHAR(4),
	cd_cinema INT,
    cd_sala INT,
    vl_poltrona DECIMAL(10,2),
    CONSTRAINT pf_compra_poltrona PRIMARY KEY (cpf_usuario, cd_compra, cd_poltrona,	cd_cinema, cd_sala),
    CONSTRAINT fk_cp_usuario FOREIGN KEY (cpf_usuario) REFERENCES compra(cpf_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cp_compra FOREIGN KEY (cd_compra) REFERENCES compra(cd_compra) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cp_poltrona FOREIGN KEY (cd_poltrona) REFERENCES poltrona(cd_poltrona) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cp_cinema FOREIGN KEY (cd_cinema) REFERENCES poltrona(cd_cinema) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cp_sala FOREIGN KEY (cd_sala) REFERENCES poltrona(cd_sala) ON DELETE CASCADE ON UPDATE CASCADE
);