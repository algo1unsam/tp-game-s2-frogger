import wollok.game.*
import background.*
import config.*

object vidas {
	
	var property cantidad
 	const property position = new Position(x = background.limite_x() + 0.5, y = background.limite_y() - 4)
	const property image = "assets/Escenario/Corazon.png"
	
	method iniciar(){
		game.addVisual(self)
		game.addVisual(vidasTexto)
		cantidad = 5
	}

	
	method perderVida(){
		cantidad -= 1
		
		if (cantidad <= 0){
			config.finalizar()
		}
	}
	
	method ganarVida(){
		cantidad += 1
	}
}

object vidasTexto{
	
	const pos = new Position(x = vidas.position().x() - 1, y = vidas.position().y() - 4)
	method text() = vidas.cantidad().toString()
	method textColor() = "000000FF"
	method position() = pos
}
