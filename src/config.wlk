import wollok.game.*
import rana.*
import escenario.*
import movimiento.*
import colisiones.*

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
	method text() = "Contacto: " + rana.contactos()
}

object colNetaRana{
	method position() = game.at(4,32)
	method text() = "Columna neta: " + rana.columnaNeta()
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
		game.onTick(100,"Validar",{colisiones.verificarContactos()})
	}

	
	method configTeclas(){
		
		keyboard.up().onPressDo({movimiento.mover(arriba)})
		
		keyboard.down().onPressDo({movimiento.mover(abajo)})
	
		keyboard.left().onPressDo({movimiento.mover(izquierda)})
	
		keyboard.right().onPressDo({movimiento.mover(derecha)})
		
	}
	
}
