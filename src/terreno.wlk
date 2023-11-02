import config.*
import background.*
import wollok.game.*

object terreno {
	
	method verificarContactos(){
		
		const obj = config.objPrincipal()
		const posX = obj.position().x()
		const columnaNeta = (posX + 4).div(8)
		
		self.buscarObjetosEnColumna(columnaNeta)
		
		if(self.estaEnAgua(posX)){
			if(not obj.tieneSuperficieMarina())
				config.objPrincipal().perderVida()		
		}
		else{
			obj.contacto(null)			
		}
		
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
	
	//Antes de usarse debe validarse con self.esColumnaDeMeta(posicion.x())
	method esArbusto(posY) = not self.esMetaOcupable(posY)
	
	//Antes de usarse debe validarse con self.esColumnaDeMeta(posicion.x())
	method esMetaOcupable(posY){
		
		return config.nivelActual().lugaresDeMetas().any({y =>
			const limSuperior = (y * 8) + 4
			const limInferior = (y * 8) - 2
			
			(posY < limSuperior and posY > limInferior) and not(config.nivelActual().metasOcupadas().contains(y))
		})
	}
	
	method esColumnaDeMeta(posicionX){
		
		const colMetaLimInferior = background.columna_de_meta() - 4
		const colMetaLimSuperior = background.columna_de_meta() + 4
		
		return
		(posicionX >= colMetaLimInferior) and (posicionX <= colMetaLimSuperior)
	}
	
	method buscarObjetosEnColumna(xEnNeto){
		
		const _xEnBruto = xEnNeto * 8
		self.contactaObjeto(_xEnBruto)
	}
	
	method contactaObjeto(xEnBruto) {
		
		var hizoContacto = false
		var objDeContacto
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
						objDeContacto = obj	
					}
				})
			}
		})
		
		if(hizoContacto)
			config.objPrincipal().contacto(objDeContacto)
			
		//Si se necesitara, se podría devolver el "hizoContacto" para verificar que se tocó algo
	}
}
