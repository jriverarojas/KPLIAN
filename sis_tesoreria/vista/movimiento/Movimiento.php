<?php
/**
*@package pXP
*@file gen-Movimiento.php
*@author  (rac)
*@date 16-08-2012 00:59:54
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Movimiento=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Movimiento.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento'
			},
			type:'Field',
			form:true 
		},
		
		{
			config:{
				name: 'nro_movimiento',
				fieldLabel: 'Nro',
				gwidth: 100				
			},
			type:'NumberField',
			filters:{pfiltro:'mov.nro_movimiento',type:'numeric'},
			grid:true,
			form:false
		},
		{   config:{
				name:'tipo_movimiento',
				fieldLabel:'Tipo Movimiento',
				typeAhead: true,
				allowBlank:false,
	    		triggerAction: 'all',
	    		forceSelection: true,
	    		selectOnFocus:true,
	   			mode:'local',
				store:['ingreso','egreso'],
				valueField:'ID',
				gwidth:100,
				width:'50%'	
				
			   },
			type:'ComboBox',
			id_grupo:1,
			form:true,
			grid:true,
			valorInicial: 'egreso'
		},
		
		{
			config:{
				name: 'fecha',
				fieldLabel: 'Fecha',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				format:'d/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'mov.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
   			config:{
   				name:'id_persona_or',
   				fieldLabel:'Persona Entrega',
   				allowBlank:false,
   				emptyText:'Persona...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Persona/ListarPersona',
					id: 'id_persona',
					root: 'datos',
					sortInfo:{
						field: 'nombre_completo1',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_persona','nombre_completo1','ci'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre_completo1#ci'}
				}),
   				valueField: 'id_persona',
   				displayField: 'nombre_completo1',
   				gdisplayField:'desc_persona_or',//mapea al store del grid
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
   				hiddenName: 'id_persona_or',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				turl:'../../../sis_seguridad/vista/persona/Persona.php',
   			    ttitle:'Personas',
   			   // tconfig:{width:1800,height:500},
   			    tdata:{},
   			    tcls:'persona',
   			    pid:this.idContenedor,
   			
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona_or']);}
   			},
   			type:'TrigguerCombo',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'por.nombre_completo1',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
	    },
		{
   			config:{
   				name:'id_concepto',
   				fieldLabel:'Concepto del Movimiento',
   				allowBlank:false,
   				emptyText:'Concepto...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_tesor/control/Concepto/ListarConcepto',
					id: 'id_concepto',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_concepto','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
   				valueField: 'id_concepto',
   				displayField: 'nombre',
   				gdisplayField:'nombre_concepto',//mapea al store del grid
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
   				hiddenName: 'id_concepto',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				turl:'../../../sis_tesor/vista/concepto/Concepto.php',
   			    ttitle:'Conceptos',
   			   // tconfig:{width:1800,height:500},
   			    tdata:{},
   			    tcls:'Concepto',
   			    pid:this.idContenedor,
   			
   				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_concepto']);}
   			},
   			type:'TrigguerCombo',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'con.nombre',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
	    },
		{
   			config:{
   				name:'id_persona_des',
   				fieldLabel:'Persona Recibe',
   				allowBlank:false,
   				emptyText:'Persona...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_seguridad/control/Persona/ListarPersona',
					id: 'id_persona',
					root: 'datos',
					sortInfo:{
						field: 'nombre_completo1',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_persona','nombre_completo1','ci'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre_completo1#ci'}
				}),
   				valueField: 'id_persona',
   				displayField: 'nombre_completo1',
   				gdisplayField:'desc_persona_des',//mapea al store del grid
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre_completo1}</p><p>CI:{ci}</p> </div></tpl>',
   				hiddenName: 'id_persona_des',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				turl:'../../../sis_seguridad/vista/persona/Persona.php',
   			    ttitle:'Personas',
   			   // tconfig:{width:1800,height:500},
   			    tdata:{},
   			    tcls:'persona',
   			    pid:this.idContenedor,
   			
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_persona_des']);}
   			},
   			type:'TrigguerCombo',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'pdes.nombre_completo1',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
	    },
		{
			config:{
				name: 'monto',
				fieldLabel: 'Monto',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'mov.monto',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'con_rendicion',
				fieldLabel: 'Con Rendición',
				allowBlank: true,
				anchor: '40%',
				gwidth: 100,
				inputValue: 'si'				
			},
			type:'Checkbox',
			//filters:{pfiltro:'mov.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'detalle',
				fieldLabel: 'Detalle(Nros Fac. y Rec.)',
				allowBlank: false,
				anchor: '80%',
				gwidth: 200
			},
			type:'TextArea',
			filters:{pfiltro:'mov.detalle',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'estado',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'mov.estado',type:'string'},
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'mov.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'mov.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Movimiento',
	ActSave:'../../sis_tesoreria/control/Movimiento/insertarMovimiento',
	ActDel:'../../sis_tesoreria/control/Movimiento/eliminarMovimiento',
	ActList:'../../sis_tesoreria/control/Movimiento/listarMovimiento',
	id_store:'id_movimiento',
	fields: [
		{name:'id_movimiento', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'con_rendicion', type: 'string'},
		{name:'nro_movimiento', type: 'numeric'},
		{name:'fecha', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_persona_des', type: 'numeric'},
		{name:'desc_persona_des', type: 'string'},
		{name:'id_concepto', type: 'numeric'},
		{name:'nombre_concepto', type: 'string'},
		{name:'id_persona_or', type: 'numeric'},
		{name:'desc_persona_or', type: 'string'},
		{name:'monto', type: 'numeric'},
		{name:'detalle', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'tipo_movimiento',type:'string'}
		
	],
	sortInfo:{
		field: 'id_movimiento',
		direction: 'DESC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		