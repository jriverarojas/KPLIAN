<?php
/**
*@package pxP
*@file Factura.php
*@author Gonzalo Sarmiento
*@date 19-09-2012
*@description Vista para mostrar una factura
*/

header("content-type=text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Factura = Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Factura.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_factura'
			},
			type:'Field',
			form:false 
		},
		
		{
			config:{
				name: 'nro_factura',
				fieldLabel: 'Nro',
				gwidth: 100				
			},
			type:'NumberField',
			filters:{pfiltro:'fac.nro_factura',type:'numeric'},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_emisor',
				fieldLabel: 'Nombre del emisor',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fac.nombre_emisor',type:'string'},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'domicilio_emisor',
				fieldLabel: 'Domicilio del emisor',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fac.domicili_emisor',type:'string'},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit_emisor',
				fieldLabel: 'Nit del emisor',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'fac.nit_emisor',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},		
		{
			config:{
				name: 'nombre_cliente',
				fieldLabel: 'Nombre del cliente',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fac.nombre_cliente',type:'string'},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'domicilio_cliente',
				fieldLabel: 'Domicilio del cliente',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fac.domicilio_cliente',type:'string'},
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nit_cliente',
				fieldLabel: 'Nit del cliente',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'fac.nit_cliente',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_emision',
				fieldLabel: 'Fecha de emision de factura',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'fac.fecha_emision',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado del registro',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'fac.estado_reg',type:'string'},
			grid:true,
			form:false
		}	
	],
	title:'Factura',
	ActSave:'../../sis_tesoreria/control/Factura/insertarFactura',
	ActDel:'../../sis_tesoreria/control/Factura/eliminarFactura',
	ActList:'../../sis_tesoreria/control/Factura/listarFactura',
	id_store:'id_factura',
	fields: [
		{name:'id_factura'},
		{name:'estado_reg', type: 'string'},
		{name:'nro_factura', type: 'numeric'},		
		{name:'nombre_emisor', type: 'string'},
		{name:'domicilio_emisor', type: 'string'},
		{name:'nit_emisor', type: 'numeric'},		
		{name:'nombre_cliente', type: 'string'},
		{name:'domicilio_cliente', type: 'string'},
		{name:'nit_cliente', type: 'numeric'},
		{name:'fecha_emision', type: 'date', dateFormat:'Y-m-d'}
		
	],
	sortInfo:{
		field: 'id_factura',
		direction: 'DESC'
	},
	bdel:true,
	bsave:true
	})
</script>