<?php
/**
*@package pXP
*@file MODFactura.php
*@author  Gonzalo Sarmiento
*@date 19-09-2012
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODFactura extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarFactura(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='tesor.ft_factura_sel';
		$this->transaccion='TSR_FAC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_factura','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('nro_factura','int4');
		$this->captura('nombre_emisor','varchar');		
		$this->captura('domicilio_emisor','varchar');
		$this->captura('nit_emisor','int4');
		$this->captura('nombre_cliente','varchar');		
		$this->captura('domicilio_cliente','varchar');
		$this->captura('nit_cliente','int4');
		$this->captura('fecha_emision','date');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarFactura(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.ft_factura_ime';
		$this->transaccion='TSR_FAC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion		
		$this->setParametro('nro_factura','nro_factura','int4');
		$this->setParametro('nombre_emisor','nombre_emisor','varchar');
		$this->setParametro('domicilio_emisor','domicilio_emisor','varchar');
		$this->setParametro('nit_emisor','nit_emisor','int4');
		$this->setParametro('nombre_cliente','nombre_cliente','varchar');
		$this->setParametro('domicilio_cliente','domicilio_cliente','varchar');
		$this->setParametro('nit_cliente','nit_cliente','int4');		
		$this->setParametro('fecha_emision','fecha_emision','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarFactura(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.ft_factura_ime';
		$this->transaccion='TSR_FAC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('nro_factura','nro_factura','int4');
		$this->setParametro('nombre_emisor','nombre_emisor','varchar');
		$this->setParametro('domicilio_emisor','domicilio_emisor','varchar');
		$this->setParametro('nit_emisor','nit_emisor','int4');
		$this->setParametro('nombre_cliente','nombre_cliente','varchar');
		$this->setParametro('domicilio_cliente','domicilio_cliente','varchar');
		$this->setParametro('nit_cliente','nit_cliente','int4');		
		$this->setParametro('fecha_emision','fecha_emision','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarFactura(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='tesor.f_factura_ime';
		$this->transaccion='TSR_FAC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_factura','id_factura','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>