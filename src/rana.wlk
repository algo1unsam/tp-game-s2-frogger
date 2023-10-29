import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 2
	var property position = self.positionInicial()
	var property puntaje = 0
	var property vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	var property estaEnAgua = false
	var property estaEnPista = false
	var property velocidad = 4
	var property columnaNeta = 0
	var property contactos = ""
	
	
	method arriba() {
		if(self.position().y() >= (game.height() - 8))
			return false
			
		const X = self.position().x()
		const nuevaY = self.position().y() + self.velocidad()
		const nuevaPos = new Position(x = X, y = nuevaY)
		position = nuevaPos
		return true
	}
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisual(self)
	}
	
	method sumarEtapas() {
		self.validarEtapa()
		estadoParaImg++
	}
	
	method validarEtapa() {
		if(self.estadoParaImg() == 7) {
			estadoParaImg = 2
		}
	}
	
	method mover(nuevaPosicion){
		self.sumarEtapas()
		self.position(nuevaPosicion)
	}

	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
	method verificarContacto(posicion) = false
	
}

	

