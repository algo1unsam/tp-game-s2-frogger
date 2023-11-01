import wollok.game.*
import objetosMoviles.*
import background.*
import rana.*
import tiempo.*
class Tronco inherits ObjetoMovil{

	const property tamanio = 20
	const property image = ""
	var property tope = false
	override method esMortal() = false
	
	override method altura() = 15
	
	override method verificarContacto(posicion) {
		
		const topeInferior = self.position().y() - 1
		const topeSuperior = self.position().y() + self.altura()
		
		return ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
		
	}
	
	
	
	override method mover(){
		position = self.position().down(1)
		self.valPosicion()
	}
	
	
	override method ejecutarContacto(){
		rana.contactos("Tronco")
	}
	
	method valPosicion(){
		if ((self.position().y() + self.tamanio()) < 0)
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
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
	override method altura() = 25
	
}

class Tronco2 inherits Tronco{
	
	override method tamanio() = 36
	override method velocidad() = 100
	override method image() = "troncos/tronco2.png"
	override method altura() = 32
	
}
class Barra inherits Tronco{
	
	override method tamanio() = 100
	override method velocidad() = 1000
	override method image() = "Escenario/TiempoBarra.png"
	override method altura() = 10
	
}
