import wollok.game.*
import background.*
import niveles.*
import rana.*


object tiempores {
	var tiempo
	const tiempoInicial = 5
 
	method text() = "tiempo restate " + tiempo.toString()

	method position() = game.at(0,background.limite_y() - 8)

	method pasarTiempo() {
		tiempo = tiempo - 1
		if (tiempo == 0) 
		game.stop()
	}
	method iniciar() {   
		tiempo = tiempoInicial
		game.onTick(1000, "tiempo", { self.pasarTiempo()})
	}

	method detener() {
		game.removeTickEvent("tiempo")
	}
}
