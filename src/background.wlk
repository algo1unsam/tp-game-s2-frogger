import wollok.game.*
import escenario.*

object background {
	
	//La grilla es de 10 celdas x 10 celdas y cada celda mide 8x8
	//A esto hay que refactorizarlo y hacerlo con un Range(0,80), por ahora lo dejo así para que nos sea más fácil orientarnos
	const posiciones = [
		
		//Primera columna
		new Position(x = 0, y = 0),
		new Position(x = 0, y = 8),
		new Position(x = 0, y = 16),
		new Position(x = 0, y = 24),
		new Position(x = 0, y = 32),
		new Position(x = 0, y = 40),
		new Position(x = 0, y = 48),
		new Position(x = 0, y = 56),
		new Position(x = 0, y = 64),
		new Position(x = 0, y = 72),
		new Position(x = 0, y = 80),
		
		//Segunda columna
		new Position(x = 8, y = 0),
		new Position(x = 8, y = 8),
		new Position(x = 8, y = 16),
		new Position(x = 8, y = 24),
		new Position(x = 8, y = 32),
		new Position(x = 8, y = 40),
		new Position(x = 8, y = 48),
		new Position(x = 8, y = 56),
		new Position(x = 8, y = 64),
		new Position(x = 8, y = 72),
		new Position(x = 8, y = 80),
		
		//Tercera columna
		new Position(x = 16, y = 0),
		new Position(x = 16, y = 8),
		new Position(x = 16, y = 16),
		new Position(x = 16, y = 24),
		new Position(x = 16, y = 32),
		new Position(x = 16, y = 40),
		new Position(x = 16, y = 48),
		new Position(x = 16, y = 56),
		new Position(x = 16, y = 64),
		new Position(x = 16, y = 72),
		new Position(x = 16, y = 80),
		
		//Cuarta columna
		new Position(x = 24, y = 0),
		new Position(x = 24, y = 8),
		new Position(x = 24, y = 16),
		new Position(x = 24, y = 24),
		new Position(x = 24, y = 32),
		new Position(x = 24, y = 40),
		new Position(x = 24, y = 48),
		new Position(x = 24, y = 56),
		new Position(x = 24, y = 64),
		new Position(x = 24, y = 72),
		new Position(x = 24, y = 80),
		
		//Quinta columna
		new Position(x = 32, y = 0),
		new Position(x = 32, y = 8),
		new Position(x = 32, y = 16),
		new Position(x = 32, y = 24),
		new Position(x = 32, y = 32),
		new Position(x = 32, y = 40),
		new Position(x = 32, y = 48),
		new Position(x = 32, y = 56),
		new Position(x = 32, y = 64),
		new Position(x = 32, y = 72),
		new Position(x = 32, y = 80),
		
		//Sexta columna
		new Position(x = 40, y = 0),
		new Position(x = 40, y = 8),
		new Position(x = 40, y = 16),
		new Position(x = 40, y = 24),
		new Position(x = 40, y = 32),
		new Position(x = 40, y = 40),
		new Position(x = 40, y = 48),
		new Position(x = 40, y = 56),
		new Position(x = 40, y = 64),
		new Position(x = 40, y = 72),
		new Position(x = 40, y = 80),
		
		//Septima columna
		new Position(x = 48, y = 0),
		new Position(x = 48, y = 8),
		new Position(x = 48, y = 16),
		new Position(x = 48, y = 24),
		new Position(x = 48, y = 32),
		new Position(x = 48, y = 40),
		new Position(x = 48, y = 48),
		new Position(x = 48, y = 56),
		new Position(x = 48, y = 64),
		new Position(x = 48, y = 72),
		new Position(x = 48, y = 80),
	
		//Octava columna
		new Position(x = 56, y = 0),
		new Position(x = 56, y = 8),
		new Position(x = 56, y = 16),
		new Position(x = 56, y = 24),
		new Position(x = 56, y = 32),
		new Position(x = 56, y = 40),
		new Position(x = 56, y = 48),
		new Position(x = 56, y = 56),
		new Position(x = 56, y = 64),
		new Position(x = 56, y = 72),
		new Position(x = 56, y = 80),
		
		//Novena columna
		new Position(x = 64, y = 0),
		new Position(x = 64, y = 8),
		new Position(x = 64, y = 16),
		new Position(x = 64, y = 24),
		new Position(x = 64, y = 32),
		new Position(x = 64, y = 40),
		new Position(x = 64, y = 48),
		new Position(x = 64, y = 56),
		new Position(x = 64, y = 64),
		new Position(x = 64, y = 72),
		new Position(x = 64, y = 80),
		
		//Decima columna
		new Position(x = 72, y = 0),
		new Position(x = 72, y = 8),
		new Position(x = 72, y = 16),
		new Position(x = 72, y = 24),
		new Position(x = 72, y = 32),
		new Position(x = 72, y = 40),
		new Position(x = 72, y = 48),
		new Position(x = 72, y = 56),
		new Position(x = 72, y = 64),
		new Position(x = 72, y = 72),
		new Position(x = 72, y = 80)
		
	]
	
	const posicionesDeHojasEnAgua = [
		
		//Ponemos 4 hojas en la fila del medio del agua
		new Position(x = 8, y = 56),
		new Position(x = 32, y = 56),
		new Position(x = 40, y = 56),
		new Position(x = 64, y = 56)
	]
	
	const posicionesDeCalaveras = [
		
		new Position(x = 8, y = 0),
		new Position(x = 40, y = 8),
		new Position(x = 16, y = 40)
	]
	
	method crearFondo(){
		
		
		//*******************************************
		//ESCENARIO
		//*******************************************
		
		posiciones.forEach({posicion =>
			
			const esTitulo = posicion.y() == 80
			
			//Es agua si está entre la séptima y novena fila
			const esAgua = posicion.y() >= 48 and posicion.y() <= 64 
			
			//Es pista si está entre la tercera y quinta fila
			const esPista = posicion.y() >= 16 and posicion.y() <= 32
			
			const esFilaDeMeta = posicion.y() == 72
			
			if(esTitulo)
				game.addVisualIn(new BarraSuperior(), posicion)
			else if(esAgua)
				game.addVisualIn(new Agua(), posicion)
			else if(esPista)
				game.addVisualIn(new Pista(), posicion)
			
			else if(esFilaDeMeta){
				if(posicion.x() == 24 or posicion.x() == 48){
					game.addVisualIn(new Meta(), posicion)
					game.addVisualIn(new Mosca(), posicion)					
				}
				else{
					game.addVisualIn(new Arbusto(), posicion)					
				}
			}
			else
				game.addVisualIn(new Pasto(), posicion)
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
