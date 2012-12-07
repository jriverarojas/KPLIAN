CREATE FUNCTION tesor.ft_movimiento_ime (
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
 FUNCION: 		tesor.ft_movimiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tesor.tmovimiento'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_movimiento	integer;
			    
BEGIN

    v_nombre_funcion = 'tesor.ft_movimiento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	if(p_transaccion='TSR_MOV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tesor.tmovimiento(
			estado_reg,
			fecha,
			id_persona_des,
			id_concepto,
			id_persona_or,
			monto,
			detalle,
			estado,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            tipo_movimiento
          	) values(
			'activo',
			now(),
			v_parametros.id_persona_des,
			v_parametros.id_concepto,
			v_parametros.id_persona_or,
			v_parametros.monto,
			v_parametros.detalle,
			'pendiente',
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.tipo_movimiento
			)RETURNING id_movimiento into v_id_movimiento;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento almacenado(a) con exito (id_movimiento'||v_id_movimiento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_id_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	elsif(p_transaccion='TSR_MOV_MOD')then

		begin
			--Sentencia de la modificacion
			update tesor.tmovimiento set
			--fecha = v_parametros.fecha,
			id_persona_des = v_parametros.id_persona_des,
			id_concepto = v_parametros.id_concepto,
			id_persona_or = v_parametros.id_persona_or,
			monto = v_parametros.monto,
			detalle = v_parametros.detalle,
			id_usuario_mod = p_id_usuario,
            tipo_movimiento = v_parametros.tipo_movimiento,
			fecha_mod = now()
			where id_movimiento=v_parametros.id_movimiento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	elsif(p_transaccion='TSR_MOV_ELI')then

		begin
			--Sentencia de la eliminacion
			update tesor.tmovimiento
            set estado_reg = 'inactivo'
            where id_movimiento=v_parametros.id_movimiento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Movimiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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