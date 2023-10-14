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
