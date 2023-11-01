import wollok.game.*
import background.*
import escenario.*
import tortuga.*
import rana.*
import auto.*
import tronco.*

class Nivel {
	
	//Sobrescribir con valores en neto de X
	const property columnasDeAgua = [] //[2,4,6]
	const property columnasDePista = [] //[2,4,6]
	
	//Tiene que devolver una lista con la posición en Y en neto de las metas
	//Cuando hablo de "neto" me refiero a posición en grilla / tamaño de celda
	const property lugaresDeMetas  = []//[2,4,6]
	
	//Sobrescribir con listas de Position
	const property posicionesDeHojasEnAgua  = [] //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	const property posicionesDeCalaveras  = [] //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	const property tortugas  = [] //[new Tortuga(0,1), new Tortuga(2, 8)] 
	const property autos  = [] //[new Vehiculo(0,1), new Vehiculo(2, 8)]
	const property troncos  = [] // new tronco() , new Tronco ()
	
	
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
			
			const esColumnaDeMeta = x == background.columna_de_meta()
			
			const esAgua = self.columnasDeAgua().any({columna => (columna * background.tamanio_celda()) == x})
			
			const esPista = self.columnasDePista().any({columna => (columna * background.tamanio_celda()) == x})
			
			if(esAgua)
				self.crearAgua(x)
			else if(esPista)
				self.crearPista(x)
			else if(esColumnaDeMeta)
				self.crearMeta(x)
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

	
	method crearMeta(x){
		
		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			const esLugarDeLLegada = self.lugaresDeMetas().any({ lugar => lugar == (y/background.tamanio_celda())})
			
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

class NivelTest inherits Nivel{
	override method columnasDeAgua() = [10,11,12,13]
	override method columnasDePista() = [2,3,4,5]
	override method lugaresDeMetas() = [0,3,4,7]
	override method posicionesDeCalaveras() = []
	override method posicionesDeHojasEnAgua() = []
	
	override method tortugas() = 
	[new Tortuga(x = 13, y = 6)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 2, y = 2, velocidad = 300),
		new Vehiculo(x = 3, y = 5, velocidad = 300),
		new Vehiculo(x = 4, y = 7, velocidad = 300),
		new Vehiculo(x = 5, y = 3, velocidad = 300)
	]
	
	override method troncos() = 
	[new Tronco1(x = 11, y = 4),
	 new Tronco2(x = 12, y = 3),
	 new Tronco0(x = 10, y = 3)
	]
}

class Nivel1 inherits Nivel{
	
	override method columnasDeAgua() = [10,11,12,13]
	override method columnasDePista() = [2,3,7,8,9]
	override method lugaresDeMetas() = [0,3,4,7]
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
