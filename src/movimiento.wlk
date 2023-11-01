import wollok.game.*
import config.*
import background.*
import colisiones.*

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
		
		const obj = config.objPrincipal()
		const posX = obj.position().x()
		return colisiones.estaEnAgua(posX)
	}
	
	method proxDireccionEsAgua(posNueva) = colisiones.estaEnAgua(posNueva.x())

	method validarMovimientoNormal(posNueva){
		
		//Debe controlarse la velocidad de movimiento
		if(self.estaEnAgua())
			return false
		
		if(self.proxDireccionEsAgua(posNueva))
			return false
		
		return not colisiones.esColumnaDeMeta(posNueva.x())
		
	}
	
	method mover(direccion){
		
		self._direccion(direccion)
		const obj = config.objPrincipal()
		const posNueva = direccion.mover(obj)
		const desdeOHaciaAgua = self.estaEnAgua() or self.proxDireccionEsAgua(posNueva)
		const esColumnaDeMeta = colisiones.esColumnaDeMeta(posNueva.x())
		
		if (self.validarMovimientoNormal(posNueva)){
			self.modificarImg()
			obj.mover(posNueva)
		}
		else if(desdeOHaciaAgua){
			self.moverDesdeOHaciaAgua(posNueva)			
		}
		else if(esColumnaDeMeta){
			
			if(colisiones.esMeta(posNueva.y())){
				self.modificarImg()
				obj.mover(posNueva)
				config.ganar()
			}
		}
		
	}
	
	method moverDesdeOHaciaAgua(posNueva){
		const deTierraHaciaAgua = (not self.estaEnAgua()) and self.proxDireccionEsAgua(posNueva)
		const deAguaHaciaAgua = self.estaEnAgua() and self.proxDireccionEsAgua(posNueva)
		const deAguaHaciaTierra = (not self.estaEnAgua()) and (not self.proxDireccionEsAgua(posNueva))
		const posActual = config.objPrincipal().position()
		
		//Caso 1: se encuentra en tierra y quiere moverse a agua
		//Dos posibles escenarios:
		//A)está en el borde de la tierra o pista
		//B) No está en el borde de la tierra o pista
		if(deTierraHaciaAgua){
			
		}
		//Caso 2: Se encuentra en agua y quiere moverse a agua
			//Debe moverse al centro de la columna de agua (moverse de a 8)
		else if(deAguaHaciaAgua){
			
		}
		
		//Caso 3: está en agua y quiere moverse a tierra
		//Debe moverse al borde de la tierra, en el que la distancia desde esa posicion
		//Al inicio de columna de agua sea cero
		else if(deAguaHaciaTierra){
			
		}
		
		
		
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
