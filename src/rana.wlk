import wollok.game.*

object rana{
	var property position = game.at(37,1)
	var puntos = 0
	var vidas = 5
	var property image = "assets/Escenario/Ranaarr.png"
	method aumentar(valor){
		puntos += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
		self.movimiento()
	}


	method puntaje() = puntos
//	method image() = "assets/Escenario/Ranaarr.png"
	
	
	
	

	method movimiento() {
		const animacion = {
			imagen1, imagen2 =>
			self.image(imagen1)
			game.schedule(300, {self.image(imagen2)})
		}
		keyboard.up().onPressDo({animacion.apply("assets/Escenario/Ranasarr.png","assets/Escenario/Ranaarr.png")})
		
		keyboard.down().onPressDo({animacion.apply("assets/Escenario/Ranasabj.png","assets/Escenario/Ranaabj.png")})
	
		keyboard.left().onPressDo({animacion.apply("assets/Escenario/Ranasizq.png","assets/Escenario/Ranaizq.png")})
	
		keyboard.right().onPressDo({animacion.apply("assets/Escenario/Ranasder.png","assets/Escenario/Ranader.png")})
	}
	
	
	method perderVida(){
		vidas -=1
		if (vidas == 0){
			game.stop()
		}
	}
	method vida()=vidas
}
	

