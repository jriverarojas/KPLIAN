<?php
/**
*@package pXP
*@file gen-ACTConcepto.php
*@author  (rac)
*@date 16-08-2012 00:55:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTConcepto extends ACTbase{    
			
	function listarConcepto(){
		$this->objParam->defecto('ordenacion','id_concepto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODConcepto','listarConcepto');
		} else{
			$this->objFunc=$this->create('MODConcepto');	
			$this->res=$this->objFunc->listarConcepto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarConcepto(){
		$this->objFunc=$this->create('MODConcepto');		
		if($this->objParam->insertar('id_concepto')){
			$this->res=$this->objFunc->insertarConcepto();			
		} else{			
			$this->res=$this->objFunc->modificarConcepto();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarConcepto(){
		$this->objFunc=$this->create('MODConcepto');		
		$this->res=$this->objFunc->eliminarConcepto();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>