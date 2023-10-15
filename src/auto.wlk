import objetosMoviles.*
import wollok.game.*


class Vehiculo inherits ObjetoMovil {
	var property velocidad
	
	var property cantidad
	
	var property numero = self.obtenerNumeroImagen()
	
	method posicionInicial() = game.at(1,18)
	
	method obtenerNumeroImagen() = new Range(start = 1, end = 2).anyOne()
	
	method image() = "Autos/Auto"+ numero + "Edited.png"
	
	method iniciar(){
			game.addVisual(self)
			game.onTick(self.velocidad(),"moverAuto",{self.mover()})
	}
	
	
	method mover(){
    	position = position.right(1)
    	if(self.position().x() > 72){
			position = self.posicionInicial()

    	}
	}
		override method Contacto() = null
	
	 
	
}

/*

object vehiculoCarrilUno inherits Vehiculo(position = game.at(1,18)  ) {
	
	method posicionInicial() = game.at(-1,18)
	
	override method velocidad() = 100
	
	override method Contacto() = null
	
	method mover(){
    	position = position.right(1)
    	if(self.position().x() > 72){
			position = self.posicionInicial()

    	}
	}
	
}

object vehiculoCarrilDos inherits Vehiculo(position = game.at(1,26)  ) {

	method posicionInicial() = game.at(-1,26)
	
	override method velocidad() = 20
	
	override method Contacto() = null
	
	method mover(){
    	position = position.right(1)
    	if(self.position().x() > 72){
			position = self.posicionInicial()

    	}
	}
	
}

object vehiculoCarrilTres inherits Vehiculo(position = game.at(1,34)  ) {
	method posicionInicial() = game.at(-1,34)
	
	override method velocidad() = 10
	
	override method Contacto() = null
	
	method mover(){
    	position = position.right(1)
    	if(self.position().x() > 72){
			position = self.posicionInicial()

    	}
	}
	
}
  */
