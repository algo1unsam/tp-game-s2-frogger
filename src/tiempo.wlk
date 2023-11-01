import wollok.game.*
import background.*
import niveles.*
import rana.*
import objetosMoviles.*

object tiempores {
	var tiempo
	const tiempoInicial = 60
 	const property positionIinmovil = game.at(118,-0.5)
 	var property position = self.positionIinmovil()
	//method text() = "tiempo restate " + tiempo.toString()
	var property image = "Escenario/crono2.png"

	//method position() = game.at(0,background.limite_y() - 8)
	method imagen()="Escenario/crono2.png"
	
	method pasarTiempo() {
		tiempo = tiempo - 1
		if (tiempo == 0) 
		game.addVisual(perder)
	
	}
	method iniciar() {   
		tiempo = tiempoInicial
		game.addVisual(self)
		game.onTick(1000, "tiempo", { self.pasarTiempo()})
	}

	method detener() {
		game.removeTickEvent("tiempo")
	}
}
object perder {

	method image() = "Menus/Nada.png"//arreglar imagen y pausar todo 
    
	method position() = game.at(60, 5)

}