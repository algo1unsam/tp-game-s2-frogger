import wollok.game.*
import objetosMoviles.*
import background.*
import rana.*

class Tronco inherits ObjetoMovil{

	const property tamanio = 20
	const property image = ""
	var property tope = false
	override method esMortal() = false
	
	method valPosicion(){
		if ((self.position().y() + self.tamanio()) < 0)
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
	}
	
	
	override method mover(){
		position = self.position().down(1)
		self.valPosicion()
	}
	
	
	override method Contacto(posicion){
		game.say(rana,"Me sente en el tronco")
	}
	
	
}

class Tronco0 inherits Tronco{
	
	override method tamanio() = 20
	override method image() = "troncos/tronco0.png"
	override method velocidad() = 40

}

class Tronco1 inherits Tronco{
	
	override method tamanio() = 28
	override method velocidad() = 60
	override method image() = "troncos/tronco1.png"
	
}

class Tronco2 inherits Tronco{
	
	override method tamanio() = 36
	override method velocidad() = 100
	override method image() = "troncos/tronco2.png"
	
}