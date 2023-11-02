import wollok.game.*
import rana.*
import escenario.*
import movimiento.*
import terreno.*

object posXRana{
	method position() = game.at(4,0)
	method text() = "X: " + rana.position().x().toString()
}

object posYRana{
	method position() = game.at(4,8)
	method text() = "Y: " + rana.position().y().toString()
}

object terrenoRana{
	method position() = game.at(4,16)
	method terreno() = if(rana.estaEnAgua()) "Agua" else if(rana.estaEnPista()) "Pista" else "Tierra"
	method text() = "Terreno: " + self.terreno()
}

object contactosRana{
	method position() = game.at(4,24)
	method text() = "Contacto: " + if(rana.contacto() != null) "Tronco" else ""
}

object colNetaRana{
	method position() = game.at(4,32)
	method text() = "Columna neta: " + rana.columnaNeta()
}

object filaNetaRana{
	method position() = game.at(4,40)
	method text() = "Fila neta: " + rana.filaNeta()
}

object supMarina{
	method position() = game.at(4,48)
	method text() = "Sup Marina: " + rana.tieneSuperficieMarina().toString()
}


object config {
	const property objPrincipal = rana
	var property nivelActual
	
	method iniciar(){
		self.configTeclas()
		game.addVisual(posXRana)
		game.addVisual(posYRana)
		game.addVisual(terrenoRana)
		game.addVisual(contactosRana)
		game.addVisual(colNetaRana)
		game.addVisual(filaNetaRana)
		game.addVisual(supMarina)
		game.onTick(100,"Validar",{terreno.verificarContactos()})
	}
	
	method finalizar(){
		objPrincipal.perderVida()
		game.say(objPrincipal,"Finalicé")
	}
	
	method ganar(){
		game.say(objPrincipal,"Gané")
	}

	
	method configTeclas(){
		
		keyboard.up().onPressDo({movimiento.mover(arriba)})
		
		keyboard.down().onPressDo({movimiento.mover(abajo)})
	
		keyboard.left().onPressDo({movimiento.mover(izquierda)})
	
		keyboard.right().onPressDo({movimiento.mover(derecha)})
		
	}
	
}
