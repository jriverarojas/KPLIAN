CREATE OR REPLACE FUNCTION tesor.ft_factura_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Tesoreria
 FUNCION:         tesor.ft_factura_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tesor.tfactura'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            19-09-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_factura    integer;
               
BEGIN

    v_nombre_funcion = 'tesor.ft_factura_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'TSR_FAC_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        19-09-2012
    ***********************************/

    if(p_transaccion='TSR_FAC_INS')then
                   
        begin
            --Sentencia de la insercion
            insert into tesor.tfactura(
            estado_reg,
            fecha_reg,
            id_usuario_reg,
            nro_factura,
            nombre_emisor,
            domicilio_emisor,
            nit_emisor,
			nombre_cliente,
 			domicilio_cliente,
            nit_cliente,
            fecha_emision
              ) values(
            'activo',
            now(),
            p_id_usuario,
            v_parametros.nro_factura,
            v_parametros.nombre_emisor,
            v_parametros.domicilio_emisor,
            v_parametros.nit_emisor,
            v_parametros.nombre_cliente,
			v_parametros.domicilio_cliente,
			v_parametros.nit_cliente,
			v_parametros.fecha_emision
            )RETURNING id_factura into v_id_factura;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Factura almacenado(a) con exito (id_factura'||v_id_factura||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_factura',v_id_factura::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************   
     #TRANSACCION:  'TSR_FAC_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        19-09-2012
    ***********************************/

    elsif(p_transaccion='TSR_FAC_MOD')then

        begin
            --Sentencia de la modificacion
            update tesor.tfactura set
            nombre_emisor = v_parametros.nombre_emisor,
            domicilio_emisor = v_parametros.domicilio_emisor,
            nit_emisor = v_parametros.nit_emisor,
            nombre_cliente = v_parametros.nombre_cliente,
            domicilio_cliente = v_parametros.domicilio_cliente,
            nit_cliente = v_parametros.nit_cliente,            
            id_usuario_mod = p_id_usuario
            where nro_factura=v_parametros.nro_factura;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Factura modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_factura',v_parametros.id_factura::INTEGER);
              
            --Devuelve la respuesta
            return v_resp;
           
        end;

    /*********************************   
     #TRANSACCION:  'TSR_FAC_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        19-09-2012
    ***********************************/

    elsif(p_transaccion='TSR_FAC_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from tesor.tfactura
            where id_factura=v_parametros.id_factura;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Factura eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_factura',v_parametros.id_factura::varchar);
             
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;