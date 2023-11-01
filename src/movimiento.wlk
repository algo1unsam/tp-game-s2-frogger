import wollok.game.*
import config.*
import background.*

object movimiento {
	
	var property _direccion
	
	method modificarImg(){
		
		var rutaImagen
		const objeto = config.objPrincipal()
		
		rutaImagen  = "assets/" + objeto.nombreAssets() + "/"
		rutaImagen += _direccion.nombre() + "/" + objeto.nombreAssets() + "-" + _direccion.nombre()
		rutaImagen += objeto.estadoParaImg().toString() + ".png"
		
		objeto.image(rutaImagen)
	}
	
	method estaEnAgua(){
		return false
	}
	
	method proxDireccionEsAgua(){
		return false
	}
	
	method proxDireccionEsArbusto(){
		return false
	}
	
	method proxDireccionFueraDeRango(){
		return false
	}
	
	method validarMovimientoNormal(){
		
		//Debe controlarse la velocidad de movimiento
		if(self.estaEnAgua())
			return false
		
		if(self.proxDireccionEsAgua())
			return false
		
		if(self.proxDireccionEsArbusto())
			return false
		
		return true
	}
	
	method mover(direccion){
		
		self._direccion(direccion)
		self.modificarImg()
		
		if (self.validarMovimientoNormal()){
			const obj = config.objPrincipal()
			obj.velocidad(obj.velocidadOriginal())
			const posNueva = direccion.mover(obj)
			obj.mover(posNueva)
		}
		else if(self.estaEnAgua() or self.proxDireccionEsAgua())
			self.moverDesdeOHaciaAgua(direccion)
		
	}
	
	method moverDesdeOHaciaAgua(direccion){
		//Caso 1: se encuentra en tierra y quiere moverse a agua
		//Dos escenarios: está en el borde de la tierra o pista
			//A)Debe moverse al centro de la columna de agua (la distancia entre el inicio
			//de columna de agua y la posactual debe ser cero)
		//No está en el borde de la tierra o pista
			//B)Debe calcularse la distancia al borde de tierra o pista y moverse ahí, en donde
			//la distancia con el inicio de columna de agua sea cero
		//Caso 2: Se encuentra en agua y quiere moverse a agua
			//Debe moverse al centro de la columna de agua (moverse de a 8)
		//Caso 3: está en agua y quiere moverse a tierra
			//Debe moverse al borde de la tierra, en el que la distancia desde esa posicion
			//Al inicio de columna de agua sea cero
	}
}

class Direccion{
	
	method velocidad() = config.objPrincipal().velocidad()
	method posActual() = config.objPrincipal().position()
	method nombre()
	method nuevaPos()
	method limite()
	
}


object arriba inherits Direccion{
	
	override method nuevaPos() = self.posActual().y() + self.velocidad()
	override method limite() = background.limite_y() - 8
	override method nombre() = "Arriba"
	
	method mover(obj){
		
		if(self.nuevaPos() <= self.limite())
			return new Position(x = self.posActual().x(), y = self.nuevaPos())
		else
			return new Position(x = self.posActual().x(), y = self.limite())
	}
}

object abajo inherits Direccion{
	
	override method nuevaPos() = self.posActual().y() - self.velocidad()
	override method limite() = 0
	override method nombre() = "Abajo"
	
	method mover(obj){
		
		if(self.nuevaPos() >= self.limite())
			return new Position(x = self.posActual().x(), y = self.nuevaPos())
		else
			return new Position(x = self.posActual().x(), y = self.limite())
	}
}
object izquierda inherits Direccion{
	
	override method nuevaPos() = self.posActual().x() - self.velocidad()
	override method limite() = 0
	override method nombre() = "Izquierda"
	
	method mover(obj){
		
		if(self.nuevaPos() >= self.limite())
			return new Position(x = self.nuevaPos(), y = self.posActual().y())
		else
			return new Position(x = self.limite(), y = self.posActual().y())
	}
	
}
object derecha inherits Direccion{
	
	override method nuevaPos() = self.posActual().x() + self.velocidad()
	override method limite() = background.limite_x() - 4
	override method nombre() = "Derecha"
	
	method mover(obj){
		
		if(self.nuevaPos() <= self.limite())
			return new Position(x = self.nuevaPos(), y = self.posActual().y())
		else
			return new Position(x = self.limite(), y = self.posActual().y())
	}
	
}
