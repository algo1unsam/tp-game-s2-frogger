import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property puntaje = 0
	var property cantVidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	var property estaEnAgua = false
	var property estaEnPista = false
	var property velocidad = 4
	var property columnaNeta = 0
	var property contactos = ""


	
	
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisual(self)
	}
	
	method perderVida(){
		cantVidas -= 1

	
		if(cantVidas == 0){
			game.stop()
			cantVidas = 3
		}
	}

	
	method verificarContacto(posicion) = false
	
}
	
