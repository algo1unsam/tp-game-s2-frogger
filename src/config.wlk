import wollok.game.*
import rana.*
import escenario.*

object config {
	
	method iniciar(){
		self.movimiento()
		self.colisiones()
	}
	
	method colisiones(){
		game.onCollideDo(rana, {obj =>
			obj.Contacto()
		})
	}
	
	
	method movimiento(){
		
		keyboard.up().onPressDo({rana.moverArriba()})
		
		keyboard.down().onPressDo({rana.moverAbajo()})
	
		keyboard.left().onPressDo({rana.moverIzquierda()})
	
		keyboard.right().onPressDo({rana.moverDerecha()})
		
	}
}
