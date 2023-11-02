import objetosMoviles.*
import wollok.game.*
import background.*
import config.*

class Vehiculo inherits ObjetoMovil {
	var property velocidad
	
	var property numero = self.obtenerNumeroImagen()
	
	override method velocidad() = velocidad
	
	method posicionInicial() {
		position =  new Position(x= x_real, y= background.limite_y())
	}
	
	method verificarContacto(posicion) {
		
		//Los autos que no sean camión tienen una unidad menor de altura
		var factor_de_altura
		if(self.numero() == 4)
			factor_de_altura = 0
		else
			factor_de_altura = 1
			
		const mitad_de_altura = self.altura().div(2) + 1
		const topeInferior = self.position().y() - mitad_de_altura
		const topeSuperior = self.position().y() + (mitad_de_altura - factor_de_altura)
		
		return ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
		
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
	
	override method ejecutarContacto(){
		config.finalizar()
	}
	
}

