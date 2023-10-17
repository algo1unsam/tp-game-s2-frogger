import wollok.game.*

object rana{
	var property position = game.at(8,1)
	var puntos = 0
	var vidas = 5
	method aumentar (valor){
		puntos += valor
	}


	method puntaje() = puntos
	method image() = "Rana1.png"

	method perderVida(){
		vidas -=1
		if (vidas == 0){
			juego.terminar()
		}
	}
	method vida()=vidas
}
	

