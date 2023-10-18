import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	var property position = self.positionInicial()
	var property puntaje = 0
	var property vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
	}

	method validarTerreno(){
		if(config.nivelActual().columnasDePista().contains(self.position().x() / 8))
			self.buscarAutos(self.position().x() / 8)
	}
	
	method buscarAutos(x){
		new Range(start = 0, end = background.limite_y()).forEach({ y =>
			game.getObjectsIn(new Position(x = x, y = y)).forEach({obj =>
				obj.Contacto(self.position())
			})
		})
	}
	
	
	method moverIzquierda(){
		self.image("assets/Rana/Izquierda/Rana-Izquierda1.png")
		self.position(self.position().left(7))
		self.validarTerreno()
	}
	
	method moverDerecha(){
		self.image("assets/Rana/Derecha/Rana-Derecha1.png")
		self.position(self.position().right(7))
		self.validarTerreno()
	}
	
	method moverArriba(){
		self.image("assets/Rana/Arriba/Rana-Arriba1.png")
		self.position(self.position().up(7))
		self.validarTerreno()
	}
	
	method moverAbajo(){
		self.image("assets/Rana/Abajo/Rana-Abajo1.png")
		self.position(self.position().down(7))
		self.validarTerreno()
	}
	
	
	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
}
	

