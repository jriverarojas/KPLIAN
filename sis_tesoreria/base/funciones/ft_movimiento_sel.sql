CREATE FUNCTION tesor.ft_movimiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Tesoreria
 FUNCION: 		tesor.ft_movimiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'tesor.tmovimiento'
 AUTOR: 		 (rac)
 FECHA:	        16-08-2012 00:59:54
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'tesor.ft_movimiento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	if(p_transaccion='TSR_MOV_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						mov.id_movimiento,
						mov.estado_reg,
						mov.nro_movimiento,
						mov.fecha,
						mov.id_persona_des,
                        pdes.nombre_completo1,
						mov.id_concepto,
                        con.nombre,
						mov.id_persona_or,
                        por.nombre_completo1,
						mov.monto,
						mov.detalle,
						mov.estado,
						mov.id_usuario_reg,
						mov.fecha_reg,
						mov.id_usuario_mod,
						mov.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        mov.tipo_movimiento,
                        mov.con_rendicion
						from tesor.tmovimiento mov
						inner join segu.tusuario usu1 on usu1.id_usuario = mov.id_usuario_reg
                        inner join segu.vpersona por on mov.id_persona_or = por.id_persona
                        inner join segu.vpersona pdes on  mov.id_persona_des = pdes.id_persona
                        inner join tesor.tconcepto con on con.id_concepto = mov.id_concepto
						left join segu.tusuario usu2 on usu2.id_usuario = mov.id_usuario_mod
				        where mov.estado_reg =''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	elsif(p_transaccion='TSR_MOV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento)
					    from tesor.tmovimiento mov
						inner join segu.tusuario usu1 on usu1.id_usuario = mov.id_usuario_reg
                        inner join segu.vpersona por on mov.id_persona_or = por.id_persona
                        inner join segu.vpersona pdes on  mov.id_persona_des = pdes.id_persona
                        inner join tesor.tconcepto con on con.id_concepto = mov.id_concepto
						left join segu.tusuario usu2 on usu2.id_usuario = mov.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql;