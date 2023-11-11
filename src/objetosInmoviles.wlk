import wollok.game.*
import config.*
import vidas.*
import background.*

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

class Corazon inherits ObjetosInmoviles{

	override method image() = "Escenario/CorazonGrande.png"
	
	override method ejecutarContacto(){
		game.removeVisual(self)
		vidas.ganarVida()
	}
	
}

class RanaGanadora inherits ObjetosInmoviles{
	override method image() = "assets/Rana/Rana-Ganadora.png"
	override method verificarContacto(posicion) = false
}

object cartelSinVidas{
	
	method image() = "assets/Menu/Cartel_SinVidas.png"
	method position() = game.at(0,0)
}

object cartelGanaste{
	
	method image() = "assets/Menu/Cartel_Ganaste.png"
	method position() = game.at(0,0)
}

object cartelPausa{
	method position() = game.at(background.limite_x().div(2) - 8,background.limite_y().div(2) - 8)
	method image() = "assets/Menu/BotonPausa.png"
}