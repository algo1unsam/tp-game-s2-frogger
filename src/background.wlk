import wollok.game.*
import escenario.*

object background {
	
	//****************
	//DATOS DE GRILLA
	//****************
	//Eje x = 15 columnas usables
	//Eje y = 9 filas usables. Una décima fila se usa para barra de estado (tiempo, vidas...)
	
	const property limite_y = 72
	const property limite_x = 120
	const property tamanio_celda = 8
	
	const property eje_x = new Range(start = 0, end = limite_x, step = 8)
	const property eje_y = new Range(start = 0, end = (limite_y - 1), step = 8)
	
	method borrarEscenario() {
		
		eje_y.forEach({y =>
			eje_x.forEach({x =>
				new Position(x = x, y = y).allElements().forEach({element => game.removeVisual(element)})
			})
		})
	}
	
	method crearBarraDeEstado(){
		eje_x.forEach({x =>
			const posicion = new Position(x = x, y = limite_y)
			game.addVisualIn(new BarraSuperior(), posicion)
		})
	}
	
	
}

class Background1 {
	
	const posicionesDeHojasEnAgua = [
		
		//Ponemos 4 hojas en la fila del medio del agua
		//new Position(x = 8, y = 56),
		//new Position(x = 32, y = 56),
		//new Position(x = 40, y = 56),
		//new Position(x = 64, y = 56)
	]
	
	const posicionesDeCalaveras = [
		
		//new Position(x = 8, y = 0),
		//new Position(x = 40, y = 8),
		//new Position(x = 16, y = 40)
	]
	
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
		
		const lugaresDeLLegada = [0,4,5,8]
		
		background.eje_y().forEach({ y =>
			const posicion = new Position(x = x, y = y)
			const esLugarDeLLegada = lugaresDeLLegada.any({ lugar => lugar == (y/background.tamanio_celda())})
			
			if(esLugarDeLLegada)
				game.addVisualIn(new Meta(), posicion)
			else
				game.addVisualIn(new Arbusto(), posicion)
		})
	}
	
	method crearFondo(){
		
		background.borrarEscenario()
		background.crearBarraDeEstado()
		
		background.eje_x().forEach({x =>
			
			const esColumnaDeMeta = x == background.limite_x() - (background.tamanio_celda())
			
			const columnasDeAgua = [10,11,12,13]
			const columnasDePista = [7,8,9]
			const columnasDePasto = [0,1,2,3,4,5,6]
			
			const esAgua = columnasDeAgua.any({columna => (columna * background.tamanio_celda()) == x})
			
			const esPista = columnasDePista.any({columna => (columna * background.tamanio_celda()) == x})
			
			const esPasto = columnasDePasto.any({columna => (columna * background.tamanio_celda()) == x})
			
			if(esAgua)
				self.crearAgua(x)
			else if(esPista)
				self.crearPista(x)
			else if(esColumnaDeMeta)
				self.crearMeta(x)
			else if(esPasto)
				self.crearPasto(x)
		})
		
		//*******************************************
		//HOJAS EN AGUA
		//*******************************************
		
		posicionesDeHojasEnAgua.forEach({posicion =>
			game.addVisualIn(new HojaEnAgua(), posicion)
		})
		
		posicionesDeCalaveras.forEach({posicion =>
			game.addVisualIn(new Calavera(), posicion)
		})
	}
	
	
}
