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
	
	method proxDireccionEsAgua(){
		return false
	}
	
	method proxDireccionEsArbusto(){
		return false
	}
	
	method proxDireccionFueraDeRango(){
		return false
	}
	
	method validarMovimiento(){
		
		if(self.proxDireccionEsAgua())
			return false
		
		if(self.proxDireccionEsArbusto())
			return false
		
		if(self.proxDireccionFueraDeRango())
			return false
		
		return true
	}
	
	method mover(direccion){
		
		if (self.validarMovimiento()){
			const obj = config.objPrincipal()
			const posNueva = direccion.mover(obj)
			self._direccion(direccion)
			self.modificarImg()
			obj.mover(posNueva)
		}
		
	}
	
	method moverDesdeOHaciaAgua(){
		
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
