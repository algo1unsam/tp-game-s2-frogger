import wollok.game.*
import background.*
import escenario.*
import tortuga.*
import rana.*
import auto.*
import tronco.*

class Nivel {
	
	//Tiene que devolver una lista con la posición en Y en neto de las metas
	//Cuando hablo de "neto" me refiero a posición en grilla / tamaño de celda
	method lugaresDeLLegada() //[2,4,6]
	
	//Sobrescribir con listas de Position
	method posicionesDeHojasEnAgua() //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	method posicionesDeCalaveras() //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	method tortugas() //[new Tortuga(0,1), new Tortuga(2, 8)] 
	method autos() //[new Vehiculo(0,1), new Vehiculo(2, 8)]
	method troncos() // new tronco() , new Tronco ()
	
	//Sobrescribir con valores en neto de X
	method columnasDeAgua() //[2,4,6]
	method columnasDePista() //[2,4,6]
	method columnasDePasto() //[2,4,6]
	
	method iniciar(){
		
		self.reiniciarEscenario()
		self.insertarFondo()
		self.insertarHojasEnAgua()
		self.insertarCalaveras()
		self.insertarTortugas()
		self.insertarAutos()
		self.insertarTroncos()
		rana.iniciar()
	}
	
	method reiniciarEscenario(){
		self.borrarEscenario()
		self.crearBarraDeEstado()
	}
	
	method insertarFondo(){
		
		background.eje_x().forEach({x =>
			
			const esColumnaDeMeta = x == background.limite_x() - background.tamanio_celda()
			
			const esAgua = self.columnasDeAgua().any({columna => (columna * background.tamanio_celda()) == x})
			
			const esPista = self.columnasDePista().any({columna => (columna * background.tamanio_celda()) == x})
			
			const esPasto = self.columnasDePasto().any({columna => (columna * background.tamanio_celda()) == x})
			
			if(esAgua)
				self.crearAgua(x)
			else if(esPista)
				self.crearPista(x)
			else if(esColumnaDeMeta)
				self.crearMeta(x)
			else if(esPasto)
				self.crearPasto(x)
		})
	}
	
	method insertarHojasEnAgua(){
		self.posicionesDeHojasEnAgua().forEach({posicion =>
			game.addVisualIn(new HojaEnAgua(), posicion)
		})
	}
	
	method insertarCalaveras(){
		self.posicionesDeCalaveras().forEach({posicion =>
			game.addVisualIn(new Calavera(), posicion)
		})
	}
	
	method insertarTortugas(){
		self.tortugas().forEach({tortuga=> tortuga.iniciar()})
	}
	
	method insertarAutos(){
		self.autos().forEach({auto=> auto.iniciar()})
	}
	
	method insertarTroncos(){
		self.troncos().forEach({tronco=> tronco.iniciar()})
	}
	
	method crearAgua(x){

		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			game.addVisualIn(new Agua(), posicion)
		})
	}
	
	method crearPista(x){
		
		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			game.addVisualIn(new Pista(), posicion)
		})
	}
	
	method crearPasto(x){
		
		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			game.addVisualIn(new Pasto(), posicion)
		})
	}
	
	method crearMeta(x){
		
		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			const esLugarDeLLegada = self.lugaresDeLLegada().any({ lugar => lugar == (y/background.tamanio_celda())})
			
			if(esLugarDeLLegada)
				game.addVisualIn(new Meta(), posicion)
			else
				game.addVisualIn(new Arbusto(), posicion)
		})
	}
	
	method borrarEscenario() {
		
		background.eje_y().forEach({y =>
			background.eje_x().forEach({x =>
				new Position(x = x, y = y).allElements().forEach({element => game.removeVisual(element)})
			})
		})
	}
	
	method crearBarraDeEstado(){
		background.eje_y().forEach({y =>
			var posicion = new Position(x = background.limite_x(), y = y)
			game.addVisualIn(new BarraSuperior(), posicion)
			posicion = new Position(x = background.limite_x(), y = (y + background.tamanio_celda() / 2))
			game.addVisualIn(new BarraSuperior(), posicion)
		})
	}
}

class Nivel1 inherits Nivel{
	
	override method columnasDeAgua() = [10,11,12,13]
	override method columnasDePista() = [2,3,7,8,9]
	override method columnasDePasto() = [0,1,4,5,6]
	override method lugaresDeLLegada() = [0,4,5,8]
	override method posicionesDeCalaveras() = []
	override method posicionesDeHojasEnAgua() = []
	
	override method tortugas() = 
	[new Tortuga(x = 11, y = 8),
	 new Tortuga(x = 11, y = 7)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 7, y = 0, velocidad = 300),
		new Vehiculo(x = 7, y = 2, velocidad = 300),
		new Vehiculo(x = 7, y = 4, velocidad = 300),
		new Vehiculo(x = 7, y = 6, velocidad = 300),
		new Vehiculo(x = 8, y = 2, velocidad = 300),
		new Vehiculo(x = 8, y = 4, velocidad = 300),
		new Vehiculo(x = 8, y = 5, velocidad = 300),
		new Vehiculo(x = 8, y = 7, velocidad = 300),
		new Vehiculo(x = 9, y = 0, velocidad = 175),
		new Vehiculo(x = 9, y = 2, velocidad = 175),
		new Vehiculo(x = 9, y = 4, velocidad = 175),
		new Vehiculo(x = 9, y = 6, velocidad = 175)
	]
	
	override method troncos() = 
	[new Tronco1(x = 12, y = 2),
	 new Tronco2(x = 10, y = 5),
	 new Tronco0(x = 13, y = 1),
	 new Tronco0(x = 13, y = 5)
	]
	
}
