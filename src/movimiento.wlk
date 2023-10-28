import config.*
import wollok.game.*

object movimiento {
	
	var property direccion
	
	method modificarImg(){
		
		var rutaImagen
		const objeto = config.objPrincipal()
		
		rutaImagen  = "assets/" + objeto.nombreAssets() + "/"
		rutaImagen += direccion + "/" + objeto.nombreAssets() + "-" + direccion
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
	
	method moverArriba(){
		self.direccion("Arriba")
		return self.validarMovimiento()
	}
	
	method moverAbajo(){
		self.direccion("Abajo")
		return self.validarMovimiento()
	}
	
	method moverIzquierda(){
		self.direccion("Izquierda")
		return self.validarMovimiento()
	}
	
	method moverDerecha(){
		self.direccion("Derecha")
		return self.validarMovimiento()
	}
	
	method validarMovimiento(){
		
		if(self.proxDireccionEsAgua())
			return false
		
		if(self.proxDireccionEsArbusto())
			return false
		
		if(self.proxDireccionFueraDeRango())
			return false
		
		self.mover()
		return true
	}
	
	method mover(){
		const obj = config.objPrincipal()
		const velocidad = obj.velocidad()
		const posActual = obj.position()
		var posNueva
		
		self.modificarImg()
		
		if(direccion == "Arriba")
			posNueva = new Position(x = posActual.x(), y = (posActual.y() + velocidad))
		if(direccion == "Abajo")
			posNueva = new Position(x = posActual.x(), y = (posActual.y() - velocidad))
		if(direccion == "Izquierda")
			posNueva = new Position(x = posActual.x() - velocidad, y = posActual.y())
		if(direccion == "Derecha")
			posNueva = new Position(x = posActual.x() + velocidad, y = posActual.y())
			
		obj.position(posNueva)
		
	}
	
	method moverDesdeOHaciaAgua(){
		
	}
}
