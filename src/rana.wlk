import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	var property estaEnAgua = false
	var property estaEnPista = false
	const property velocidadOriginal = 3
	var property velocidad = velocidadOriginal
	var property contacto = null
	var property tieneSuperficieMarina = false
	
	method iniciar(){
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

	method perderVida(){
		vidas -=1	
		if (vidas == 0){
			config.finalizar()			
			game.stop()
		}
		self.position(self.positionInicial())
	}
	
	method verificarContacto(posicion) = false
	
}

	

