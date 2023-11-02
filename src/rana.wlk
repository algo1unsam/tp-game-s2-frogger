import wollok.game.*
import config.*
import background.*
import objetosInmoviles.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property vidas
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	const property velocidadOriginal = 3
	var property velocidad = velocidadOriginal
	var property contacto = null
	var property tieneSuperficieMarina = false
	var property moscasComidas = 0
	
	method iniciar(){
		self.vidas(5)
		game.addVisual(self)
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
		
		config.reiniciarTiempo()
		
		if(moscasComidas == config.nivelActual().moscasTotales())
			config.ganar()
	}

	method perderVida(){
		
		vidas -=1	
		
		if (vidas == 0)
			config.finalizar()
			
		self.position(self.positionInicial())
	}
	
	method verificarContacto(posicion) = false
	
}
