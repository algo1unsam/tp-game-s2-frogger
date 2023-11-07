import wollok.game.*
import config.*
import background.*
import objetosInmoviles.*
import vidas.*
import tiempo.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	const property velocidadOriginal = 3
	var property velocidad = velocidadOriginal
	var property contacto = null
	var property tieneSuperficieMarina = false
	var property moscasComidas = 0
	
	method iniciar(){
		game.addVisual(self)
	}
	
	method finalizar(){
		moscasComidas = 0
		position = positionInicial
	}

	method sumarEtapas() {
		self.validarEtapa()
		estadoParaImg++
	}
	
	method validarEtapa() {
		if(self.estadoParaImg() == 3)
			estadoParaImg = 1
	}
	
	method mover(nuevaPosicion){
		self.sumarEtapas()
		self.position(nuevaPosicion)
	}
	
	method ganar(posicionYDeMeta){
		
		const posYNeta = (posicionYDeMeta + 4).div(8)
		
		const pos = new Position(x = background.columna_de_meta(), y = (posYNeta * background.tamanio_celda()) + 1)
		game.addVisual(new RanaGanadora(position = pos))
		moscasComidas++
		config.nivelActual().metasOcupadas().add(posYNeta)
		
		game.removeVisual(self)
		position = positionInicial
		game.addVisual(self)
		
		if(config.nivelActual().nroNivel() == 1 or config.nivelActual().nroNivel() == 2){
			tiempo.finalizar()
			tiempo.iniciar(false)			
		}
		
		if(moscasComidas == config.nivelActual().moscasTotales()){
			config.ganar()
			moscasComidas = 0
		}
	}

	method perderVida(){
		
		vidas.perderVida()
		self.position(self.positionInicial())
	}
	
	method verificarContacto(posicion) = false
	
}
