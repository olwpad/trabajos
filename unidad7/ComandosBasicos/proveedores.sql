DROP DATABASE IF EXISTS proveedores;

CREATE DATABASE IF NOT EXISTS proveedores CHARACTER SET utf8mb4;
USE proveedores;

CREATE TABLE categoria (
    cod_categoria   INT             NOT NULL,
    nombre          VARCHAR(20)     NOT NULL,
    PRIMARY KEY (cod_categoria)
);

CREATE TABLE pieza (
    cod_pieza       INT             NOT NULL,
    nombre          VARCHAR(20)     NOT NULL,
    color           VARCHAR(15)     NOT NULL,
    precio          DECIMAL(10,2)   NOT NULL    CHECK (precio > 0),
    cod_categoria   INT             NOT NULL,
    PRIMARY KEY (cod_pieza),
    FOREIGN KEY (cod_categoria) REFERENCES categoria(cod_categoria) ON DELETE CASCADE
);

CREATE TABLE proveedor (
    cod_prov        INT             NOT NULL,
    nombre          VARCHAR(20)     NOT NULL,
    direccion       VARCHAR(40)     NOT NULL,
    ciudad          VARCHAR(30)     NOT NULL,
    departamento    VARCHAR(20)     NOT NULL,
    tipo            ENUM ('Natural','Jurídica')  NOT NULL,
    PRIMARY KEY (cod_prov)
);

CREATE TABLE pnatural (
    cod_prov        INT             NOT NULL,
    atributo_x      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (cod_prov),
    FOREIGN KEY (cod_prov) REFERENCES proveedor(cod_prov) ON DELETE CASCADE
);

CREATE TABLE pjuridica (
    cod_prov        INT             NOT NULL,
    atributo_y      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (cod_prov),
    FOREIGN KEY (cod_prov) REFERENCES proveedor(cod_prov) ON DELETE CASCADE
);

CREATE TABLE suministra (
    cod_prov        INT             NOT NULL,
    cod_pieza       INT             NOT NULL,
    fecha_hora      DATETIME        NOT NULL,
    cantidad        INT             NOT NULL    CHECK (cantidad > 0),
    FOREIGN KEY (cod_prov) REFERENCES proveedor(cod_prov) ON DELETE CASCADE,
    FOREIGN KEY (cod_pieza) REFERENCES pieza(cod_pieza) ON DELETE CASCADE,
    PRIMARY KEY (cod_prov, cod_pieza, fecha_hora)
);

DROP TABLE IF EXISTS suministra;