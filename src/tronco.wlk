import wollok.game.*
import objetosMoviles.*
import background.*
import rana.*

class Tronco0 inherits ObjetoMovil{
	
	var property tope = false
	
	const property tamanio = 20
	
	override method velocidad() = 40
	
	override method esMortal() = false
	
	
	override method mover(){
		position = self.position().down(1)
		self.valPosicion()
	}
	

	method valPosicion(){
		if ((self.position().y() + self.tamanio()) < 0){
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
		}
	}

	method image(){return "troncos/tronco0.png"} 
	
	override method Contacto(){
		game.say(rana,"Me sente en el tronco")
	}
	
}

class Tronco1 inherits Tronco0{
	
	override method tamanio() = 28
	
	override method velocidad() = 60
	
	override method image(){return "troncos/tronco1.png"} 
	
}

class Tronco2 inherits Tronco0{
	
	override method tamanio() = 36
	
	override method velocidad() = 100
	
	override method image(){return "troncos/tronco2.png"} 
	
}