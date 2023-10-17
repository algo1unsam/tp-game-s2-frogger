import objetosMoviles.*
import wollok.game.*
import background.*
import rana.*

class Vehiculo inherits ObjetoMovil {
	var property velocidad
	
	var property numero = self.obtenerNumeroImagen()
	
	override method velocidad() = velocidad
	
	method posicionInicial() {
		position =  new Position(x= x_real, y= background.limite_y())
	} 
	
	method obtenerNumeroImagen() = new Range(start = 1, end = 4).anyOne()
	
	method image() = "Autos/Auto" + numero + ".png"
	
	
	override method mover(){
    	position = position.down(1)
		self.valPosicion()
	}
	
	method valPosicion(){
		if (self.position().y() < 0){
			self.posicionInicial()
		}
	}
		
	override method Contacto() {
		game.say(rana,"Croack")
	}
	
	 
	
}

