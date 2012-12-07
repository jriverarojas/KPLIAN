<?php
/**
*@package pXP
*@file gen-ACTMovimiento.php
*@author  (rac)
*@date 16-08-2012 00:59:54
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimiento extends ACTbase{    
			
	function listarMovimiento(){
		$this->objParam->defecto('ordenacion','id_movimiento');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('MODMovimiento','listarMovimiento');
		} else{
			$this->objFunc=$this->create('MODMovimiento');
			$this->res=$this->objFunc->listarMovimiento();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimiento(){
		$this->objFunc=$this->create('MODMovimiento');
		if($this->objParam->insertar('id_movimiento')){
			$this->res=$this->objFunc->insertarMovimiento();			
		} else{			
			$this->res=$this->objFunc->modificarMovimiento();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimiento(){
		$this->objFunc=$this->create('MODMovimiento');	
		$this->res=$this->objFunc->eliminarMovimiento();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>