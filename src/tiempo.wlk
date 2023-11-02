import wollok.game.*
import background.*
import config.*

object tiempo {
	const tiempoInicial = 80
 	const property position = new Position(x = background.limite_x(), y = background.limite_y() - 15)
	const property image = "assets/Menu/Reloj.png"
	var property tiempoRestante = tiempoInicial
	
	method iniciar() {   
		tiempoRestante = tiempoInicial
		game.addVisual(self)
		game.addVisual(tiempoTexto)
		game.addVisual(barraDeTiempo)
		game.onTick(1000, "tiempo", { self.pasarTiempo()})
	}
	
	method pasarTiempo() {
		
		tiempoRestante = tiempoRestante - 1
		
		const nuevaPosBarraDeTiempo = new Position(x = barraDeTiempo.position().x(), y =barraDeTiempo.position().y() - 0.5)
		barraDeTiempo.position(nuevaPosBarraDeTiempo)
		
		if (tiempoRestante == 0) 
			config.finalizar()
	}

	method detener() {game.removeTickEvent("tiempo")}
	
	method reiniciar() {game.onTick(1000, "tiempo", { self.pasarTiempo()})}
}

object tiempoTexto {
	
	const pos = new Position(x = tiempo.position().x() - 1, y = tiempo.position().y() - 6)
	method text() = tiempo.tiempoRestante().toString()
	method textColor() = "000000FF"
	method position() = pos
}

object barraDeTiempo {

	var property position = self.posicionInicial()
	
	method image() = "assets/Menu/TiempoBarra.png"//arreglar imagen y pausar todo     
    method posicionInicial() = new Position(x = background.limite_x(), y = -31)
    

}