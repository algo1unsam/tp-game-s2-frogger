import wollok.game.*
import config.*
import background.*
import terreno.*

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
		return terreno.estaEnAgua(posX)
	}
	
	method proxDireccionEsAgua(posNueva) = terreno.estaEnAgua(posNueva.x())

	method validarMovimientoNormal(posNueva){
		
		//Debe controlarse la velocidad de movimiento
		if(self.estaEnAgua())
			return false
		
		if(self.proxDireccionEsAgua(posNueva))
			return false
		
		return not terreno.esColumnaDeMeta(posNueva.x())
		
	}
	
	method mover(direccion){
		
		if(not config.pausa()){
			
			self._direccion(direccion)
			const obj = config.objPrincipal()
			const posNueva = direccion.mover(obj)
			const desdeOHaciaAguaHorizontal = 
				(self.estaEnAgua() or self.proxDireccionEsAgua(posNueva)) 
				and 
				(direccion.nombre() == "Izquierda" or direccion.nombre() == "Derecha")
			
			const desdeOHaciaAguaVertical = 
				(self.estaEnAgua() or self.proxDireccionEsAgua(posNueva)) 
				and 
				(direccion.nombre() == "Arriba" or direccion.nombre() == "Abajo")
			
			var esColumnaDeMeta
			
			if(self.estaEnAgua() and direccion.nombre() == "Derecha"){
				const proximaColumna = ((posNueva.x() + 4).div(8) + 1) * 8
				esColumnaDeMeta = terreno.esColumnaDeMeta(proximaColumna)	
			}
			else{
				esColumnaDeMeta = terreno.esColumnaDeMeta(posNueva.x())			
			}
			
			if (self.validarMovimientoNormal(posNueva)){
				obj.tieneSuperficieMarina(false)
				self.modificarImg()
				obj.mover(posNueva)
			}
			else if(desdeOHaciaAguaHorizontal and not esColumnaDeMeta){
				obj.tieneSuperficieMarina(false)
				self.modificarImg()
				self.moverDesdeOHaciaAguaHorizontal(posNueva)			
			}
			else if(desdeOHaciaAguaVertical){
				self.modificarImg()
				obj.mover(posNueva)		
			}
			else if(esColumnaDeMeta){
				
				if(terreno.esMetaOcupable(posNueva.y())){
					self.modificarImg()
					const posicionDeMeta = new Position(x = background.columna_de_meta(), y = posNueva.y())
					obj.mover(posicionDeMeta)
				}
			}	
		}
	}
	
	method ocuparMeta(posicionDeMeta){
		
	}
	
	method moverDesdeOHaciaAguaHorizontal(posNueva){
		
		const obj = config.objPrincipal()
		const posActual = obj.position()
		
		const columnaNetaOrigen = (posActual.x() + 4).div(8) * background.tamanio_celda()
		var columnaNetaDestino = (posNueva.x() + 4).div(8) * background.tamanio_celda()
		var inicioDeColumnaDestino
		
		if(columnaNetaDestino == columnaNetaOrigen and self.estaEnAgua()){
			if(posActual.x() >= posNueva.x()){
				columnaNetaDestino -= background.tamanio_celda()
				inicioDeColumnaDestino = columnaNetaDestino + 4
			}
			else{
				columnaNetaDestino += background.tamanio_celda()
				inicioDeColumnaDestino = columnaNetaDestino - 4
			}
			
		} else{
			
			if(posActual.x() >= posNueva.x())
				inicioDeColumnaDestino = columnaNetaDestino + 4
			else
				inicioDeColumnaDestino = columnaNetaDestino - 4
		}
		
		const posColNetaDestino = new Position(x = columnaNetaDestino, y = posNueva.y())
		const posInicioDeColDestino = new Position(x = inicioDeColumnaDestino, y = posNueva.y())
		var distanciaEnXParaRecorrer
		
		const deTierraHaciaAgua = (not self.estaEnAgua()) and self.proxDireccionEsAgua(posColNetaDestino)
		const deAguaHaciaAgua = self.estaEnAgua() and self.proxDireccionEsAgua(posColNetaDestino)
		const deAguaHaciaTierra = self.estaEnAgua() and (not self.proxDireccionEsAgua(posColNetaDestino))
		
		//Caso 1: se encuentra en tierra y quiere moverse a agua
		//Dos posibles escenarios:
		//A)está en el borde de la tierra o pista
		//B) No está en el borde de la tierra o pista
		if(deTierraHaciaAgua){
			distanciaEnXParaRecorrer = posActual.x() - posInicioDeColDestino.x()
			
			if(distanciaEnXParaRecorrer == 0)
				obj.mover(posColNetaDestino)
			else
				obj.mover(posInicioDeColDestino)
		}
		//Caso 2: Se encuentra en agua y quiere moverse a agua
			//Debe moverse al centro de la columna de agua (moverse de a 8)
		else if(deAguaHaciaAgua){
			obj.mover(posColNetaDestino)
		}
		
		//Caso 3: está en agua y quiere moverse a tierra
		//Debe moverse al borde de la tierra, en el que la distancia desde esa posicion
		//Al inicio de columna de agua sea cero
		else if(deAguaHaciaTierra){
			obj.mover(posInicioDeColDestino)
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
