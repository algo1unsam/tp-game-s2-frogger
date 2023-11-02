import wollok.game.*
import background.*
import config.*

object vidas {
	
	var property cantidad
 	const property position = new Position(x = background.limite_x(), y = background.limite_y() - 4)
	const property image = "assets/Menu/Corazon.png"
	
	method iniciar(){
		self.cantidad(5)
		game.addVisual(self)
		game.addVisual(vidasTexto)
	}
	
	method perderVida(){
		cantidad -= 1
		
		if (cantidad== 0)
			config.finalizar()
	}
	
	method ganarVida(){
		cantidad += 1
	}
}

object vidasTexto{
	
	const pos = new Position(x = vidas.position().x() - 1, y = vidas.position().y() - 6)
	method text() = vidas.cantidad().toString()
	method textColor() = "000000FF"
	method position() = pos
}
