class Escenario {
	
	method image()
	method esMortal() = false
	method esPosicionable() = true
		
}

class BarraSuperior inherits Escenario{
	
	override method esPosicionable() = false
	override method image() = "Escenario/Barra sup.png"
	
}

class Pasto inherits Escenario{
	
	override method image() = "Escenario/Pasto.png"
	
}

class Agua inherits Escenario{
	
	override method image() = "Escenario/Agua.png"
	override method esMortal() = true
	
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

class Mosca inherits Escenario{
	
	override method image() = "Escenario/Mosca.png"
	
}

class Calavera inherits Escenario{
	
	override method image() = "Escenario/Calavera.png"
	override method esMortal() = true
	
}