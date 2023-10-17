import wollok.game.*
import objetosMoviles.*
import background.*

class Tronco0 inherits ObjetoMovil{
	
	var property tope = false
	
	override method velocidad() = 40
	
	override method esMortal() = false
	
	override method mover(){
		position = self.position().down(1)
		self.valPosicion()
	}
	

	method valPosicion(){
		if (self.position().y() < 0){
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
		}
	}

	method image(){return "troncos/tronco0.png"} 
	
	override method Contacto(){}
	
}

class Tronco1 inherits Tronco0{
	
	override method velocidad() = 60
	
	method image(){return "troncos/tronco1.png"} 
	
}

class Tronco2 inherits Tronco0{
	
	override method velocidad() = 100
	
	method image(){return "troncos/tronco2.png"} 
	
}