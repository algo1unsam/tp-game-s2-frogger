import wollok.game.*
import config.*

class ObjetosInmoviles {
	
	const property position
	method image()
	method verificarContacto(posicion) {
	
		const topeInferior = self.position().y() - 2
		const topeSuperior = self.position().y() + 4
		
		return ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
	
	}
	
	method ejecutarContacto(){}
}

class Mosca inherits ObjetosInmoviles{
	
	override method image() = "Escenario/Mosca.png"

	
	override method ejecutarContacto(){
		game.removeVisual(self)
		config.objPrincipal().ganar(self.position().y())
	}
	
}

class Calavera inherits ObjetosInmoviles{

	override method image() = "Escenario/Calavera.png"
	
	override method ejecutarContacto(){
		game.removeVisual(self)
		config.objPrincipal().perderVida()
	}
	
}

class RanaGanadora inherits ObjetosInmoviles{
	override method image() = "assets/Rana/Izquierda/Rana-Izquierda1.png"
	override method verificarContacto(posicion) = false
}
