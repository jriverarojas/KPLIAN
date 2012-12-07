<?php
/**
*@package pXP
*@file ACTFactura.php
*@author  Gonzalo Sarmiento
*@date 19-09-2012
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFactura extends ACTbase{    
			
	function listarFactura(){
		$this->objParam->defecto('ordenacion','id_factura');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFactura','listarFactura');
		} else{
			$this->objFunc=$this->create('MODFactura');	
			$this->res=$this->objFunc->listarFactura($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFactura(){
		$this->objFunc=$this->create('MODFactura');	
		if($this->objParam->insertar('id_factura')){
			$this->res=$this->objFunc->insertarFactura();			
		} else{			
			$this->res=$this->objFunc->modificarFactura();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFactura(){
		$this->objFunc=$this->create('MODFactura');		
		$this->res=$this->objFunc->eliminarFactura();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>