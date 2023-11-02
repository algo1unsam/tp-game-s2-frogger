import wollok.game.*
import config.*

class Escenario {
	
	method image()
	method esPosicionable() = true
	method verificarContacto(posicion) = false
	
}

class BarraSuperior inherits Escenario{
	
	override method esPosicionable() = false
	override method image() = "Escenario/Barra sup.png"
	
}

class Agua inherits Escenario{
	
	override method image() = "Escenario/Agua.png"
	
}

class Pista inherits Escenario{
	
	override method image() = "Escenario/Pista.png"
	
}

class Arbusto inherits Escenario{
	
	override method image() = "Escenario/Arbusto.png"
	override method esPosicionable() = false
	
}

class Meta inherits Escenario{
	
	override method image() = "Escenario/Meta.png"
	
}

class HojaEnAgua inherits Escenario{
	
	override method image() = "Escenario/Hoja.png"
	
}