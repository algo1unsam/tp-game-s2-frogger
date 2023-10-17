import wollok.game.*
import background.*
import escenario.*
import tortuga.*
import rana.*

class Nivel {
	
	//Tiene que devolver una lista con la posición en Y en neto de las metas
	//Cuando hablo de "neto" me refiero a posición en grilla / tamaño de celda
	method lugaresDeLLegada() //[2,4,6]
	
	//Sobrescribir con listas de Position
	method posicionesDeHojasEnAgua() //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	method posicionesDeCalaveras() //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	method tortugas() //[new Tortuga(0,1), new Tortuga(2, 8)] 
	
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
		rana.iniciar()
	}
	
	method reiniciarEscenario(){
		self.borrarEscenario()
		self.crearBarraDeEstado()
	}
	
	method insertarFondo(){
		
		background.eje_x().forEach({x =>
			
			const esColumnaDeMeta = x == background.limite_x() - (background.tamanio_celda())
			
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
		background.eje_x().forEach({x =>
			const posicion = new Position(x = x, y = background.limite_y())
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
}
