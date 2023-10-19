import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property puntaje = 0
	var property vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	var estaEnAgua = false
	var estaEnPista = false
	
	
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
	}

	method validarTerreno(){
		
		const pistasEnTerreno = config.nivelActual().columnasDePista()
		const aguasEnTerreno = config.nivelActual().columnasDeAgua()
		const posX = self.position().x()
		
		estaEnPista = pistasEnTerreno.any({x => posX >= x and posX <= (x + 7)})
		estaEnAgua = aguasEnTerreno.any({x => posX >= x and posX <= (x + 7)})
		
		if(estaEnPista)
			self.buscarAutos(posX)
		//Aplicar la misma logica para el agua
	}
	
	method buscarAutos(x){
		new Range(start = 0, end = background.limite_y()).forEach({ y =>
			game.getObjectsIn(new Position(x = x, y = y)).forEach({obj =>
				obj.Contacto(self.position())
			})
		})
	}
	
	

	
	
	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
}
	

