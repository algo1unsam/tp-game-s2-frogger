import wollok.game.*
import objetosMoviles.*
import background.*
import config.*

class Tronco inherits ObjetoMovilMarino{

	const property tamanio = 20
	const property image = ""
	
	override method altura() = 15
	
	override method verificarContacto(posicion) {
		
		const topeInferior = self.position().y() - 1
		const topeSuperior = self.position().y() + self.altura()
		
		return ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
		
	}
	
	
	
	override method mover(){
		
		if(not config.pausa()){			
			position = self.position().down(1)
			self.valPosicion()
			if(self.contactaObjPrincipal()){
				const objPrincipal = config.objPrincipal()
				const nuevaPos = new Position(x = objPrincipal.position().x(), y = objPrincipal.position().down(1).y())
				objPrincipal.position(nuevaPos)
				
				if(objPrincipal.position().y() < 0)
					self.sacarSuperficieMarina(objPrincipal)
			}
		}
	}
	
	
	override method ejecutarContacto(){
		const obj = config.objPrincipal()
		self.darSuperficieMarina(obj)
	}
	
	method valPosicion(){
		if ((self.position().y() + self.tamanio()) < 0)
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
	}
}

class Tronco0 inherits Tronco{
	
	override method tamanio() = 20
	override method image() = "troncos/Tronco0.png"
	override method velocidad() = 40

}

class Tronco1 inherits Tronco{
	
	override method tamanio() = 28
	override method velocidad() = 60
	override method image() = "troncos/Tronco1.png"
	override method altura() = 25
	
}

class Tronco2 inherits Tronco{
	
	override method tamanio() = 36
	override method velocidad() = 100
	override method image() = "troncos/Tronco2.png"
	override method altura() = 32
}