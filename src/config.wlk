import wollok.game.*
import rana.*
import escenario.*
import movimiento.*
import terreno.*


object config {
	const property objPrincipal = rana
	var property nivelActual
	var property objetos = #{}
	
	method iniciar(nivel){
		self.nivelActual(nivel)
		nivel.iniciar()
		self.configTeclas()
		game.onTick(100,"Validar",{terreno.verificarContactos()})
		self.reiniciarTiempo()
	}
	
	method reiniciarTiempo(){}
	
	method finalizar(){
		
		game.removeTickEvent("Validar")
		
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		game.say(objPrincipal,"Finalicé")
		
		game.schedule(4000,game.stop())
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
