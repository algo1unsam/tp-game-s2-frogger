import wollok.game.*
import rana.*
import escenario.*

object config {
	
	var property nivelActual
	
	method iniciar(){
		self.movimiento()
		self.colisiones()
	}
	
	method colisiones(){

	}
	
	
	method movimiento(){
		
		keyboard.up().onPressDo({rana.moverArriba()})
		
		keyboard.down().onPressDo({rana.moverAbajo()})
	
		keyboard.left().onPressDo({rana.moverIzquierda()})
	
		keyboard.right().onPressDo({rana.moverDerecha()})
		
	}
}
