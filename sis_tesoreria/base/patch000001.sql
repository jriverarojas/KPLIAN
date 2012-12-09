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

ALTER TABLE tesor.tconcepto
  ADD COLUMN tipo_movimiento VARCHAR(15) NOT NULL;
  
ALTER TABLE tesor.tmovimiento
  ADD COLUMN id_proyecto INTEGER NOT NULL;
  
ALTER TABLE tesor.tmovimiento
  ADD CONSTRAINT tmovimiento_fk_id_proyecto FOREIGN KEY (id_proyecto)
    REFERENCES segu.tproyecto(id_proyecto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
    NOT DEFERRABLE;

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'TESOR', E'Sistema de Tesoreria', E'2012-12-07', E'TSR', E'activo', E'tesoreria', NULL);
  
select pxp.f_insert_tgui ('SISTEMA DE TESORERIA', '', 'TESOR', 'si',NULL , '', 1, '', '', 'TESOR');
select pxp.f_insert_tgui ('Conceptos', 'Conceptos', 'CONC', 'si', 1, 'sis_tesoreria/vista/concepto/Concepto.php', 2, '', 'Concepto', 'TESOR');
select pxp.f_insert_tgui ('Movimiento', 'Movimiento', 'MOV', 'si', 2, 'sis_tesoreria/vista/movimiento/Movimiento.php', 2, '', 'Movimiento', 'TESOR');
select pxp.f_insert_tgui ('Factura', 'Factura', 'FAC', 'si', 3, 'sis_tesoreria/vista/factura/Factura.php', 2, '', 'Factura', 'TESOR');
select pxp.f_insert_testructura_gui ('TESOR', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CONC', 'TESOR');
select pxp.f_insert_testructura_gui ('MOV', 'TESOR');
select pxp.f_insert_testructura_gui ('FAC', 'TESOR');



/***********************************F-SCP-JRR-TESOR-1-7/12/2012****************************************/