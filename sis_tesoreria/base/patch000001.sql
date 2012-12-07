/***********************************I-SCP-JRR-TESOR-1-7/12/2012****************************************/
CREATE TABLE tesor.tfactura (
  id_factura SERIAL, 
  nombre_emisor VARCHAR(50) NOT NULL, 
  domicilio_emisor VARCHAR(50) NOT NULL, 
  nit_emisor INTEGER NOT NULL, 
  nombre_cliente VARCHAR(50) NOT NULL, 
  domicilio_cliente VARCHAR(50) NOT NULL, 
  nit_cliente INTEGER NOT NULL, 
  fecha_emision DATE NOT NULL, 
  nro_factura INTEGER NOT NULL, 
  CONSTRAINT tfactura_pkey PRIMARY KEY(id_factura)
) INHERITS (pxp.tbase)
WITH OIDS;

CREATE TABLE tesor.tconcepto (
  id_concepto SERIAL, 
  nombre VARCHAR(50) NOT NULL, 
  descripcion TEXT, 
  CONSTRAINT tconcepto_table2_nombre_key UNIQUE(nombre), 
  CONSTRAINT tconcepto_table2_pkey PRIMARY KEY(id_concepto)
) INHERITS (pxp.tbase)
WITH OIDS;

CREATE TABLE tesor.tmovimiento (
  id_movimiento SERIAL, 
  id_concepto INTEGER NOT NULL, 
  id_persona_or INTEGER NOT NULL, 
  id_persona_des INTEGER NOT NULL, 
  detalle TEXT NOT NULL, 
  monto NUMERIC(18,2) NOT NULL, 
  fecha DATE NOT NULL, 
  estado VARCHAR(20) NOT NULL, 
  nro_movimiento SERIAL, 
  tipo_movimiento VARCHAR(20) NOT NULL, 
  con_rendicion VARCHAR(2), 
  CONSTRAINT tmovimiento_nro_movimiento_key UNIQUE(nro_movimiento), 
  CONSTRAINT tmovimiento_pkey PRIMARY KEY(id_movimiento), 
  CONSTRAINT tmovimiento_fk_id_concepto FOREIGN KEY (id_concepto)
    REFERENCES tesor.tconcepto(id_concepto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tmovimiento_fk_id_persona_des FOREIGN KEY (id_persona_des)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT tmovimiento_fk_id_persona_or FOREIGN KEY (id_persona_or)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;
/***********************************F-SCP-JRR-TESOR-1-7/12/2012****************************************/