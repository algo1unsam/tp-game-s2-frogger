import wollok.game.*
import rana.*
import escenario.*
import movimiento.*
import terreno.*
import tiempo.*
import vidas.*
import menuPrincipal.*
import objetosInmoviles.*

object config {
	const property objPrincipal = rana
	var property nivelActual
	const property objetos = #{}
	const property nivelesGanados = #{}
	var property pausa = false
	var property jugando = false
	
	method iniciar(nivel){
		game.boardGround("Escenario/Fondo_pasto.png")
		self.nivelActual(nivel)
		nivel.iniciar()
		game.onTick(100,"Validar",{terreno.verificarContactos()})
		self.iniciarTiempo()
		self.iniciarVidas()
		self.jugando(true)
	}
	
	method iniciarVidas(){
		vidas.iniciar()
	}
	
	method iniciarTiempo(){
		tiempo.iniciar()		
	}
	
	method pausarDespausar(){
		
		if(jugando){
			if(pausa)
				self.reiniciar()
			else
				self.pausar()			
		}
	}
	
	method pausar(){
		
		game.addVisual(cartelPausa)
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		tiempo.pausar()
		pausa = true
	}
	
	method reiniciar(){
		pausa = false
		game.removeVisual(cartelPausa)
		nivelActual.reiniciarMovimientos()
		tiempo.reiniciar()
	}
	
	method finalizar(){
		
		game.removeTickEvent("Validar")
		
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		self.objetos().clear()
		tiempo.finalizar()
		game.allVisuals().forEach({obj => game.removeVisual(obj)})
		game.addVisual(cartelSinVidas)
		
		game.schedule(4000,{self.irAlMenuPrincipal()})
	}
	
	method irAlMenuPrincipal(){
		self.jugando(false)
		game.removeVisual(cartelSinVidas)
	}
	
	method ganar(){
		nivelesGanados.add(nivelActual.nroNivel())
		game.say(objPrincipal,"Gané")		
	}

	
	method configTeclas(){
		
		keyboard.up().onPressDo({
			if(jugando)
				movimiento.mover(arriba)
		})
		
		keyboard.down().onPressDo({
			if(jugando)
				movimiento.mover(abajo)
		})
	
		keyboard.left().onPressDo({
			if(jugando)
				movimiento.mover(izquierda)
			else
				menuPrincipal.desplazarANivelDeIzquierda()
		})
	
		keyboard.right().onPressDo({
			if(jugando)
				movimiento.mover(derecha)
			else
				menuPrincipal.desplazarANivelDeDerecha()
		})
		
		keyboard.space().onPressDo({
			if(jugando)
				self.pausarDespausar()
		})
		
		keyboard.enter().onPressDo({
			if(not jugando)
				menuPrincipal.seleccionarNivel(menuPrincipal.nivelSeleccionado())
		})
		
	}
	
}


object cartelPausa{
	method text() = "PAUSA"
	method position() = game.center()
	method textColor() = "000000FF"
}