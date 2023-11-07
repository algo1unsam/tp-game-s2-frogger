import wollok.game.*
import background.*
import escenario.*
import tortuga.*
import config.*
import auto.*
import tronco.*
import objetosInmoviles.*

class Nivel {
	
	//Sobrescribir con valores en neto de X
	const property columnasDeAgua = [] //[2,4,6]
	const property columnasDePista = [] //[2,4,6]
	const property columnasDePasto = [] //[2,4,6]
	
	//Tiene que devolver una lista con la posición en Y en neto de las metas
	//Cuando hablo de "neto" me refiero a posición en grilla / tamaño de celda
	const property lugaresDeMetas  = []//[2,4,6]
	const property metasOcupadas = []
	
	//Sobrescribir con listas de Position
	const property posicionesDeHojasEnAgua  = [] //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	const property posicionesDeCalaveras  = [] //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	const property posicionesDeCorazones  = [] //[new Position(x = 0, y = 0), new Position(x = 10, y = 8)] 
	const property tortugas  = [] //[new Tortuga(0,1), new Tortuga(2, 8)] 
	const property autos  = [] //[new Vehiculo(0,1), new Vehiculo(2, 8)]
	const property troncos  = [] // new tronco() , new Tronco ()
	
	method nroNivel()
	
	method moscasTotales() = self.lugaresDeMetas().size()
	
	method iniciar(){
		
		config.id_objetos().clear()
		self.reiniciarEscenario()
		self.insertarFondo()
		self.insertarHojasEnAgua()
		self.insertarCalaveras()
		self.insertarCorazones()
		self.insertarTortugas()
		self.insertarAutos()
		self.insertarTroncos()
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
			const nuevaX = posicion.x() * background.tamanio_celda()
			const nuevaY = posicion.y() * background.tamanio_celda()
			game.addVisual(new Calavera(position = new Position(x = nuevaX, y = nuevaY)))
		})
	}
	
	method insertarCorazones(){
		self.posicionesDeCorazones().forEach({posicion =>
			const nuevaX = posicion.x() * background.tamanio_celda()
			const nuevaY = posicion.y() * background.tamanio_celda()
			game.addVisual(new Corazon(position = new Position(x = nuevaX, y = nuevaY)))
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
	
	method pausar(){
		config.id_objetos().forEach({ obj =>
			game.removeTickEvent(obj)
		})
	}
	method reiniciarMovimientos(){
		self.tortugas().forEach({tortuga=> tortuga.reiniciar()})
		self.autos().forEach({auto=> auto.reiniciar()})
		self.troncos().forEach({tronco=> tronco.reiniciar()})
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
			const esLugarDeLLegada = self.lugaresDeMetas().any({ lugar => lugar == (y/background.tamanio_celda())})
			
			if(esLugarDeLLegada){
				game.addVisualIn(new Meta(), posicion)
				game.addVisual(new Mosca(position = posicion))				
			}
			else
				game.addVisualIn(new Arbusto(), posicion)
		})
	}
	
	method borrarEscenario() {
		game.allVisuals().forEach({obj => game.removeVisual(obj)})
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
	
	override method iniciar(){
		super()
		//Freno el movimiento de objetos en el nivel para testing
		self.pausar()
	}
	override method columnasDeAgua() = [7,8]
	override method columnasDePista() = [2,3,4]
	override method columnasDePasto() = [0,1,5,6]
	override method lugaresDeMetas() = [4]
	override method posicionesDeCalaveras() = [

	]
	override method posicionesDeCorazones() = [new Position(x = 0, y = 6)]
	override method nroNivel() = 2
	
	override method tortugas() = 
	[ new Tortuga(x = 8, y = 4, id_unico = 0)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 4, y = 0, id_unico = 1, velocidad = 150),
		new Vehiculo(x = 4, y = 2, id_unico = 2, velocidad = 150),
		new Vehiculo(x = 4, y = 4, id_unico = 3, velocidad = 150),
		new Vehiculo(x = 3, y = 0, id_unico = 4, velocidad = 300),
		new Vehiculo(x = 3, y = 4, id_unico = 5, velocidad = 300)
	]
	
	override method troncos() = 
	[
		new Tronco0(x = 7, y = 3, id_unico = 6)
	]
	
}

class Nivel1 inherits Nivel{
	
	override method columnasDeAgua() = [7,8]
	override method columnasDePista() = [3,4]
	override method columnasDePasto() = [0,1,2,5,6]
	override method lugaresDeMetas() = [4]
	override method posicionesDeCalaveras() = [

	]
	override method posicionesDeCorazones() = []
	override method nroNivel() = 2
	
	override method tortugas() = 
	[
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 4, y = 0, id_unico = 1, velocidad = 150),
		new Vehiculo(x = 4, y = 2, id_unico = 2, velocidad = 150),
		new Vehiculo(x = 4, y = 4, id_unico = 3, velocidad = 150),
		new Vehiculo(x = 3, y = 0, id_unico = 4, velocidad = 300),
		new Vehiculo(x = 3, y = 4, id_unico = 5, velocidad = 300)
	]
	
	override method troncos() = 
	[
		new Tronco0(x = 7, y = 3, id_unico = 6),
		new Tronco0(x = 7, y = 6, id_unico = 7),
		new Tronco1(x = 8, y = 0, id_unico = 8)
	]
	
}

class Nivel2 inherits Nivel{
	
	override method columnasDeAgua() = [4,8]
	override method columnasDePista() = [3,5]
	override method columnasDePasto() = [0,1,2,4,6,7]
	override method lugaresDeMetas() = [0,2]
	override method posicionesDeCalaveras() = [
		
		new Position(x = 0,y = 6),
		new Position(x = 2,y = 6),
		new Position(x = 0,y = 7),
		new Position(x = 2,y = 7),
		new Position(x = 6,y = 1),
		new Position(x = 6,y = 2),
		new Position(x = 6,y = 3),
		new Position(x = 6,y = 4),
		new Position(x = 7,y = 1),
		new Position(x = 7,y = 2),
		new Position(x = 7,y = 3),
		new Position(x = 7,y = 4)
	]
	override method posicionesDeCorazones() = [new Position(x = 1,y = 7)]
	override method nroNivel() = 3
	
	override method tortugas() =
	
	[new Tortuga(x = 8, y = 8, id_unico = 0),
	 new Tortuga(x = 8, y = 5, id_unico = 1),
	 new Tortuga(x = 8, y = 2, id_unico = 2)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 3, y = 0, id_unico = 3, velocidad = 300),
		new Vehiculo(x = 3, y = 4, id_unico = 4, velocidad = 300),
		new Vehiculo(x = 3, y = 7, id_unico = 5, velocidad = 300),
		new Vehiculo(x = 5, y = 0, id_unico = 6, velocidad = 300),
		new Vehiculo(x = 5, y = 2, id_unico = 7, velocidad = 300),
		new Vehiculo(x = 5, y = 4, id_unico = 8, velocidad = 300)
	]
	
	override method troncos() = 
	[
		new Tronco1(x = 4, y = 0, id_unico = 14)
	]
	
}

class Nivel3 inherits Nivel{
	override method columnasDeAgua() = [7,8]
	override method columnasDePista() = [3,4,5,6]
	override method columnasDePasto() = [0,1,2]
	override method lugaresDeMetas() = [2,4,6]
	override method posicionesDeCalaveras() = [
		new Position(x = 0,y = 6),
		new Position(x = 2,y = 6),
		new Position(x = 0,y = 7),
		new Position(x = 2,y = 7)
	]
	override method posicionesDeCorazones() = [new Position(x = 1,y = 7)]
	override method nroNivel() = 4
	
	override method tortugas() = 
	[new Tortuga(x = 8, y = 7, id_unico = 1),
	 new Tortuga(x = 8, y = 3, id_unico = 2)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 4, y = 0, id_unico = 3, velocidad = 150),
		new Vehiculo(x = 4, y = 2, id_unico = 4, velocidad = 150),
		new Vehiculo(x = 4, y = 4, id_unico = 5, velocidad = 150),
		new Vehiculo(x = 4, y = 6, id_unico = 6, velocidad = 150),
		new Vehiculo(x = 3, y = 0, id_unico = 7, velocidad = 300),
		new Vehiculo(x = 3, y = 4, id_unico = 8, velocidad = 300),
		new Vehiculo(x = 3, y = 7, id_unico = 9, velocidad = 300),
		new Vehiculo(x = 5, y = 0, id_unico = 10, velocidad = 300),
		new Vehiculo(x = 5, y = 2, id_unico = 11, velocidad = 300),
		new Vehiculo(x = 5, y = 4, id_unico = 12, velocidad = 300),
		new Vehiculo(x = 5, y = 6, id_unico = 13, velocidad = 300),
		new Vehiculo(x = 6, y = 0, id_unico = 14, velocidad = 150),
		new Vehiculo(x = 6, y = 2, id_unico = 15, velocidad = 150),
		new Vehiculo(x = 6, y = 4, id_unico = 16, velocidad = 150),
		new Vehiculo(x = 6, y = 6, id_unico = 17, velocidad = 150)
	]
	
	override method troncos() = 
	[
		new Tronco2(x = 7, y = 0, id_unico = 18)
	]
	
}

class Nivel4 inherits Nivel{
	override method columnasDeAgua() = [1,4,6,8]
	override method columnasDePista() = [2,3,5,7]
	override method columnasDePasto() = [0]
	override method lugaresDeMetas() = [1,4,5,7]
	override method posicionesDeCalaveras() = [
		new Position(x = 0,y = 1),
		new Position(x = 0,y = 3),
		new Position(x = 0,y = 4),
		new Position(x = 0,y = 5)
	]
	override method posicionesDeCorazones() = [
		new Position(x = 0,y = 7),
		new Position(x = 0,y = 0)
	]
	override method nroNivel() = 1
	
	override method tortugas() = 
	
	[	new Tortuga(x = 1, y = 7, id_unico = 1),
		new Tortuga(x = 8, y = 7, id_unico = 2)
	]
	
	override method autos() = 
	[
		new Vehiculo(x = 2, y = 0, id_unico = 3, velocidad = 150),
		new Vehiculo(x = 2, y = 2, id_unico = 4, velocidad = 150),
		new Vehiculo(x = 2, y = 4, id_unico = 5, velocidad = 150),
		new Vehiculo(x = 2, y = 6, id_unico = 6, velocidad = 150),
		new Vehiculo(x = 3, y = 0, id_unico = 7, velocidad = 300),
		new Vehiculo(x = 3, y = 4, id_unico = 8, velocidad = 300),
		new Vehiculo(x = 3, y = 7, id_unico = 9, velocidad = 300),
		new Vehiculo(x = 5, y = 0, id_unico = 10, velocidad = 300),
		new Vehiculo(x = 5, y = 2, id_unico = 11, velocidad = 300),
		new Vehiculo(x = 5, y = 4, id_unico = 12, velocidad = 300),
		new Vehiculo(x = 5, y = 6, id_unico = 13, velocidad = 300),
		new Vehiculo(x = 7, y = 0, id_unico = 14, velocidad = 150),
		new Vehiculo(x = 7, y = 2, id_unico = 15, velocidad = 150),
		new Vehiculo(x = 7, y = 4, id_unico = 16, velocidad = 150),
		new Vehiculo(x = 7, y = 6, id_unico = 17, velocidad = 150)
	]
	
	override method troncos() = 
	[
		new Tronco0(x = 4, y = 4, id_unico = 18),
		new Tronco1(x = 6, y = 4, id_unico = 19)
	]
	
}