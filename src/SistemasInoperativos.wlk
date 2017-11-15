class Aplicacion {
	var disco
	var memoria

	constructor (_disco, _memoria){
		disco = _disco
		memoria = _memoria
	}
	method memoria() = memoria 
	method disco() = disco 
}

class SistemaInoperativo inherits Aplicacion{

	override method disco() = self.appsPorDefecto().sum({a => a.disco()}) + disco


	method limiteEjecucion()
	method appsPorDefecto()

	method sobrecarga(app,equipo) {}	
	// Ignoran la aplicacion 
}
// En primer lugar tenemos a GuinDOS, un sistema que tuvo sus primeros orígenes en QDOS. Viene con muchas aplicaciones por defecto y soporta una cantidad total de aplicaciones activas que se calcula como el doble de la versión. (por ejemplo, la versión 3.11 soporta 6 aplicaciones ejecutando simultáneamente). 
class GuinDOS inherits SistemaInoperativo{
	var version
	var appsPorDefecto
	constructor (disco, memoria, vers, apps) = super(disco,memoria) {
		version = vers
		appsPorDefecto = apps
	}
	override method sobrecarga(app, equipo) {
		equipo.cerrarTodas()
		//equipo.aceptarEjecucion(app)
		//Sería mas realista para que valide si la nueva aplicacion puede ejecutarse sola 
		 equipo.ejecutar(app)
	}
	override method limiteEjecucion() = version*2
	override method appsPorDefecto() = appsPorDefecto
}

class PinguinOS inherits SistemaInoperativo{
	var distribucion
	constructor(disco, memoria, _distribucion) = super(disco, memoria){
		distribucion = _distribucion
	}
	override method limiteEjecucion() = distribucion.limiteEjecucion()
	override method appsPorDefecto() = distribucion.appsPorDefecto()
}

class Distribucion {
	var limiteEjecucion
	var appsPorDefecto
	constructor(_limiteEjecucion, _appsPorDefecto) {
		limiteEjecucion = _limiteEjecucion
		appsPorDefecto = _appsPorDefecto
	}
	method limiteEjecucion() = limiteEjecucion
	method appsPorDefecto() = appsPorDefecto	
}

class IPear inherits SistemaInoperativo{
	var dolaresInvertidos
	const appDonacion = new Aplicacion(10,10)
	constructor(disco, memoria, dinero) = super(disco,memoria){
		dolaresInvertidos = dinero
		
	}
	method recibirDonacion(monto){
		dolaresInvertidos += monto
	}
	override method limiteEjecucion() = dolaresInvertidos/1000
	override method appsPorDefecto() = [appDonacion]


}
object sinMemoria inherits Exception{}
object sinLugarEnDisco inherits Exception{}
object noPuedeEjecutarseAplicacionEnEjecucion inherits Exception{}
object noPuedeEjecutarseAplicacionNoInstalada inherits Exception{}
object noPuedeDetenerseAplicacionDetenida inherits Exception {}

class Equipo{
	var disco
	var memoria
	var si
	var appsEnEjecucion = []
	var appsInstaladas = []
	
	constructor(_disco, _memoria){
		disco = _disco
		memoria = _memoria
	}
	
	method si() = si
	
	//method appsEnEjecucion() = appsEnEjecucion
	
	method cantAppsEnEjecucion() = appsEnEjecucion.size()
	
	method discoSuficiente(instalable) 
		= instalable.disco() <= self.discoLibre() 

	method discoLibre() = disco
			
	method puedeInstalarApp(app) 
		= self.discoSuficiente(app)
		and self.siInstalado()
		and not appsInstaladas.contains(app)
	
	method siInstalado()
	  = si != null

	method instalarSI(nuevoSI){
		if (not self.discoSuficiente(nuevoSI))
			throw sinLugarEnDisco
		si = nuevoSI
		appsInstaladas.addAll(nuevoSI.appsPorDefecto())
		disco -= si.disco()
	}
	method instalarApp(app){
	//No se pedia, pero es necesario agregar aplicaciones para testear 
	//Se usa la validación para que tenga mas sentido
		if(self.puedeInstalarApp(app)) {
			appsInstaladas.add(app)
			disco -= app.disco()
		}
	}
	

	method encender(){
		if (si.memoria() > memoria)
			throw sinMemoria
	}

	method memoriaSuficiente(ejecutable) 
		= ejecutable.memoria() <= self.memoriaLibre() 
	
	method memoriaLibre() 
		= memoria - self.memoriaOcupada()
		
	method memoriaOcupada()
		= ([si]+appsEnEjecucion).sum{a => a.memoria()}
		//En vez de concatenar todo, se puede sumar por separado: 
		//si.memoria() + appsEjecutando.sum{a => a.memoria()}
	
	method ejecutar(app){  
		if (self.laAppEstaEjecutandose(app))
			throw noPuedeEjecutarseAplicacionEnEjecucion	
		//la consigna no lo pide explicitamente, pero tiene sentido que sea una excepcion
		if (self.laAppNoEstaInstalada(app))
			throw noPuedeEjecutarseAplicacionNoInstalada	
		//la consigna no lo pide explicitamente
		if(self.llegoAlLimiteDeAplicaciones() or not self.memoriaSuficiente(app) )
			si.sobrecarga(app,self)
			// La forma de administrar la sobrecarga de memoria depende del SI
		else
			appsEnEjecucion.add(app)
	}	
	method llegoAlLimiteDeAplicaciones()
		= self.cantAppsEnEjecucion() + 1 > si.limiteEjecucion()		
	
	method laAppEstaEjecutandose(app)
		= appsEnEjecucion.contains(app)

	method laAppNoEstaInstalada(app)
		= not appsInstaladas.contains(app)
			

	method detener(app){
		if (not self.laAppEstaEjecutandose(app))
			throw noPuedeDetenerseAplicacionDetenida	
		appsEnEjecucion.remove(app)
	}
	method cerrarTodas() {
		appsEnEjecucion.clear() 
	}
	//Estadisticas 
	method estaExplotado() 
		= self.memoriaOcupada() >= memoria*0.9

	method puedeConTodas() 
		= memoria - si.memoria() > appsInstaladas.sum{a=>a.memoria()}
	
	method corriendoLaPeor() 
		= appsEnEjecucion.contains(appsInstaladas.max{a=>a.memoria()})
} 
 


