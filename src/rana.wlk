import wollok.game.*

object rana{
	var property position = game.at(0,16)
	var puntos = 0
	var vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	
	method aumentar(valor){
		puntos += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
	}


	method puntaje() = puntos
//	method image() = "assets/Escenario/Ranaarr.png"
	
	
	method moverIzquierda(){
		self.image("assets/Rana/Izquierda/Rana-Izquierda1.png")
		self.position(self.position().left(7))
	}
	
	method moverDerecha(){
		self.image("assets/Rana/Derecha/Rana-Derecha1.png")
		self.position(self.position().right(7))
	}
	
	method moverArriba(){
		self.image("assets/Rana/Arriba/Rana-Arriba1.png")
		self.position(self.position().up(7))
	}
	
	method moverAbajo(){
		self.image("assets/Rana/Abajo/Rana-Abajo1.png")
		self.position(self.position().down(7))	
	}
	

	method movimiento() {
		//const animacion = {
		//	imagen1, imagen2 =>
		//	self.image(imagen1)
		//	game.schedule(300, {self.image(imagen2)})
		//}
		//keyboard.up().onPressDo({animacion.apply(self.image(),"assets/Rana/Arriba/Rana-Arriba1.png")})
		
		//keyboard.down().onPressDo({animacion.apply(self.image(),"assets/Rana/Abajo/Rana-Abajo1.png")})
	
		//keyboard.left().onPressDo({animacion.apply(self.image(),"assets/Rana/Izquierda/Rana-Izquierda1.png")})
	
		//keyboard.right().onPressDo({animacion.apply(self.image(),"assets/Rana/Derecha/Rana-Derecha1.png")})
	}
	
	
	method perderVida(){
		vidas -=1
		if (vidas == 0){
			game.stop()
		}
	}
	method vida()=vidas
}
	

