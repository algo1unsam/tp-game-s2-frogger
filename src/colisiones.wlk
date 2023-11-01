import config.*
import background.*
import wollok.game.*

object colisiones {
	
	method verificarContactos(){
		
		const obj = config.objPrincipal()
		const posX = obj.position().x()
		const columnaNeta = (posX + 4).div(8)
		
		//Variable de debug:
		obj.columnaNeta(columnaNeta)
		//Variable de debug
		obj.estaEnPista(self.estaEnPista(posX))
		//Variable de debug
		obj.estaEnAgua(self.estaEnAgua(posX))
		
		//Cuando lancemos el juego reemplazar por "self.estaEnPista(posX)"
		if(obj.estaEnPista() or obj.estaEnAgua())
			self.buscarObjetosEnColumna(columnaNeta)
		
		
	}
	
	method estaEnAgua(posX){
		
		const aguasEnTerreno = config.nivelActual().columnasDeAgua()
		
		return aguasEnTerreno.any({x => 
			
			const limiteInferior = (x * 8) - 4
			const limiteSuperior = (x * 8) + 4
			
			posX > limiteInferior and posX < limiteSuperior
		})
	}
	
	method estaEnPista(posX){
		
		const pistasEnTerreno = config.nivelActual().columnasDePista()
		
		return pistasEnTerreno.any({x =>
			
			const limiteInferior = (x * 8) - 4
			//Los autos están una unidad a la izquierda del centro de la pista, por eso es +3 y no +4
			const limiteSuperior = (x * 8) + 3
			
			posX > limiteInferior and posX < limiteSuperior
		})
	}
	
	method buscarObjetosEnColumna(xEnNeto){
		
		const _xEnBruto = xEnNeto * 8
		const hizoContacto = self.contactaObjeto(_xEnBruto)
		
		if(not hizoContacto)
			//Variable de debug
			config.objPrincipal().contactos("")
	}
	
	method contactaObjeto(xEnBruto) {
		
		var hizoContacto = false
		const yEnColumnaActual = new Range(start = 0, end = background.limite_y())
		const posObjPrincipal = config.objPrincipal().position()
		
		yEnColumnaActual.forEach({ y =>
			
			const posicionEnCurso = new Position(x = xEnBruto, y = y)
			const _contactos = game.getObjectsIn(posicionEnCurso)
			
			if(_contactos.size() > 0){
				
				_contactos.forEach({obj =>
					
					//Tiene que verificarse si el resultado de "verificarContacto" es true
					//antes de la función "ejecutarContacto" (por ej. todos los escenarios
					//Devuelven false en verificarContacto porque no tienen un método llamado
					//"ejecutarContacto")
					
					if(obj.verificarContacto(posObjPrincipal)){
						//Este método se llama cada vez que la rana toca a un obj
						obj.ejecutarContacto()	
						hizoContacto = true				
					}
				})
			}
		})
		
		return hizoContacto
	}
}
