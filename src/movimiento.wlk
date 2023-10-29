import config.*
import wollok.game.*

object movimiento {
	
	var property direccion
	
	method modificarImg(){
		
		var rutaImagen
		const objeto = config.objPrincipal()
		
		rutaImagen  = "assets/" + objeto.nombreAssets() + "/"
		rutaImagen += direccion.nombre() + "/" + objeto.nombreAssets() + "-" + direccion.nombre()
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
	
	method mover(direccionDestino){
		self.validarMovimiento()
		self.direccion(direccionDestino)
		
		const obj = config.objPrincipal()
		const velocidad = obj.velocidad()
		const posActual = obj.position()
		var posNueva
		
		self.modificarImg()
		
		posNueva = direccionDestino.mover(obj,velocidad, posActual)
		if(false != posNueva )
			obj.mover(posNueva)
		
	}
	
	method moverDesdeOHaciaAgua(){
		
	}
}


object arriba{
	
	
	const property nombre = "Arriba"
	
	method mover(obj,velocidad,posActual){
		if(obj.position().y() < (game.height() - 8)){
			return new Position(x = posActual.x(), y = (posActual.y() + velocidad))
		}
		return false
	}
}

object abajo{
	const property nombre = "Abajo"
	
	method mover(obj,velocidad,posActual){
		if(obj.position().y() > 0){
			return new Position(x = posActual.x(), y = (posActual.y() - velocidad))
		}
		return false
	}
}
object izquierda{
	const property nombre = "Izquierda"
	
	method mover(obj,velocidad,posActual){
		if(obj.position().x() > 0){
			return new Position(x = posActual.x() - velocidad, y = posActual.y())
		}
		return false
	}
	
}
object derecha{
	const property nombre = "Derecha"
	
	method mover(obj,velocidad,posActual){
		if(obj.position().x() < (game.width() - 8)){
			return new Position(x = posActual.x() + velocidad, y = posActual.y())
		}
		return false
	}
	
}
