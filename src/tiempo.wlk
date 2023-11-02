import wollok.game.*
import background.*
import config.*

object tiempo {
	const tiempoInicial = 100
 	const property position = new Position(x = background.limite_x(), y = background.limite_y() - 9)
	const property image = "assets/Menu/Reloj.png"
	var property tiempoRestante = tiempoInicial
	
	method iniciar() {   
		tiempoRestante = tiempoInicial
		game.addVisual(self)
		tiempoTexto.iniciar()
		barraDeTiempo.iniciar()
		game.onTick(1000, "tiempo", { self.pasarTiempo()})
	}

	
	method pasarTiempo() {
		
		tiempoRestante = tiempoRestante - 1
		
		const nuevaPosBarraDeTiempo = new Position(x = barraDeTiempo.position().x(), y =barraDeTiempo.position().y() - 0.5)
		barraDeTiempo.position(nuevaPosBarraDeTiempo)
		
		if (tiempoRestante == 0) 
			config.finalizar()
	}
	
	method finalizar() {
		game.removeTickEvent("tiempo")
		game.removeVisual(self)
		game.removeVisual(tiempoTexto)
		game.removeVisual(barraDeTiempo)
	}

	method pausar() {game.removeTickEvent("tiempo")}
	
	method reiniciar() {game.onTick(1000, "tiempo", { self.pasarTiempo()})}
}

object tiempoTexto {
	
	const posicionInicial = new Position(x = tiempo.position().x() - 1, y = tiempo.position().y() - 4)
	method text() = tiempo.tiempoRestante().toString()
	method textColor() = "000000FF"
	method position() = posicionInicial
	
	method iniciar(){
    	game.addVisual(self)
    }
}

object barraDeTiempo {

	
	var property position = posicionInicial
    const posicionInicial = new Position(x = background.limite_x(), y = -21)
	method image() = "assets/Menu/TiempoBarra.png"//arreglar imagen y pausar todo     
    method iniciar(){
    	position = posicionInicial
    	game.addVisual(self)
    }
    

}