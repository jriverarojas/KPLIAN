CREATE OR REPLACE FUNCTION tesor.ft_factura_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Tesoreria
 FUNCION:         tesor.ft_factura_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'tesor.tfactura'
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

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
               
BEGIN

    v_nombre_funcion = 'tesor.ft_factura_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'TSR_FAC_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        19-09-2012
    ***********************************/

    if(p_transaccion='TSR_FAC_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        fac.id_factura,
                        fac.estado_reg,
                        fac.nro_factura,
                        fac.nombre_emisor,
                        fac.domicilio_emisor,
                        fac.nit_emisor,
                        fac.nombre_cliente,
                        fac.domicilio_cliente,
                        fac.nit_cliente,                        
                        fac.fecha_emision                       
                        from tesor.tfactura fac
                        where ';
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
            --Devuelve la respuesta
            return v_consulta;
            
                       
        end;

    /*********************************   
     #TRANSACCION:  'TSR_FAC_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        19-09-2012
    ***********************************/

    elsif(p_transaccion='TSR_FAC_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_factura)
                        from tesor.tfactura fac
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;