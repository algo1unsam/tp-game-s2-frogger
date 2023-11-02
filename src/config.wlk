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
	const property nivelesDesbloqueados = #{1}
	var property pausa = false
	var property jugando = false
	
	method iniciar(nivel){
		self.nivelActual(nivel)
		nivel.iniciar()
		objPrincipal.iniciar()
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
		
		pausa = true
		game.addVisual(cartelPausa)
		self.nivelActual().pausar()
		tiempo.pausar()
	}
	
	method reiniciar(){
		pausa = false
		game.removeVisual(cartelPausa)
		self.nivelActual().reiniciarMovimientos()
		tiempo.reiniciar()
	}
	
	method finalizar(){
		
		self.objPrincipal().moscasComidas(0)
		game.removeTickEvent("Validar")
		
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		self.objetos().clear()
		tiempo.finalizar()
		game.allVisuals().forEach({obj => game.removeVisual(obj)})
		game.addVisual(cartelSinVidas)
		
		game.schedule(4000,{self.irAlMenuPrincipal(false)})
	}
	
	method irAlMenuPrincipal(gano){
		self.jugando(false)
		
		if(gano)
			game.removeVisual(cartelGanaste)
		else
			game.removeVisual(cartelSinVidas)
			
		menuPrincipal.mostrar()
	}
	
	method ganar(){
		nivelesDesbloqueados.add(nivelActual.nroNivel())
		
		game.removeTickEvent("Validar")
		
		self.objetos().forEach({obj =>
			game.removeTickEvent(obj)
		})
		
		self.objetos().clear()
		tiempo.finalizar()
		game.allVisuals().forEach({obj => game.removeVisual(obj)})
		game.addVisual(cartelGanaste)
		
		game.schedule(4000,{self.irAlMenuPrincipal(true)})
	}
	
	method frenarBusquedaDeContactos(){game.removeTickEvent("Validar")}
	
	method reanudarBusquedaDeContactos(){game.onTick(100,"Validar",{terreno.verificarContactos()})}

	
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
			//En un momento dado, lo había testeado y funcionaba.
			//Ahora, el desapusar los objetos quedan inmóviles
			//if(jugando)
			//	self.pausarDespausar()
		})
		
		keyboard.enter().onPressDo({
			if(not jugando)
				menuPrincipal.seleccionarNivel(menuPrincipal.nivelSeleccionado())
		})
		
	}
	
}