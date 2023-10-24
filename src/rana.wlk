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
	
	method mover(direccion){
		
		if(direccion == "Arriba")
			self.mover_arriba()
		else if(direccion == "Abajo")
			self.mover_abajo()
		else if(direccion == "Izquierda")
			self.mover_izquierda()
		else if(direccion == "Derecha")
			self.mover_derecha()
	}
	method mover_arriba(){self.position().up(1)}
	method mover_abajo(){self.position().down(1)}
	method mover_izquierda(){self.position().left(1)}
	method mover_derecha(){self.position().right(1)}

	
	
	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
	method Contacto(posicion){}
	
}
	

