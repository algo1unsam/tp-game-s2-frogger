import wollok.game.*
import rana.*
import escenario.*
import movimiento.*
import terreno.*
import tiempo.*
import vidas.*

object config {
	const property objPrincipal = rana
	var property nivelActual
	var property objetos = #{}
	var property pausa = false
	
	method iniciar(nivel){
		self.nivelActual(nivel)
		nivel.iniciar()
		self.configTeclas()
		game.onTick(100,"Validar",{terreno.verificarContactos()})
		self.iniciarTiempo()
		self.iniciarVidas()
	}
	
	method iniciarVidas(){
		vidas.iniciar()
	}
	
	method iniciarTiempo(){
		tiempo.iniciar()		
	}
	
	method pausarDespausar(){
		if(pausa)
			self.reiniciar()
		else
			self.pausar()
	}
	
	method pausar(){
		
		game.addVisual(cartelPausa)
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		pausa = true
	}
	
	method reiniciar(){
		pausa = false
		game.removeVisual(cartelPausa)
		nivelActual.reiniciarMovimientos()
	}
	
	method finalizar(){
		
		game.removeTickEvent("Validar")
		
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		self.objetos().clear()
		
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
		
		keyboard.space().onPressDo({self.pausarDespausar()})
		
	}
	
}


object cartelPausa{
	method text() = "PAUSA"
	method position() = game.center()
}