import config.*
import background.*
import wollok.game.*

object colisiones {
	
	method verificarContactos(){
		
		const obj = config.objPrincipal()
		
		const pistasEnTerreno = config.nivelActual().columnasDePista()
		const aguasEnTerreno = config.nivelActual().columnasDeAgua()
		const posX = obj.position().x()
		
		obj.columnaNeta((posX + 4).div(8))

		obj.estaEnPista(pistasEnTerreno.any({x =>
			
			const limiteInferior = (x * 8) - 4
			
			//Los autos están una unidad a la izquierda del centro de la pista, por eso es +3 y no +4
			const limiteSuperior = (x * 8) + 3
			
			posX > limiteInferior and posX < limiteSuperior
		}))
		
		obj.estaEnAgua(aguasEnTerreno.any({x => 
			const limiteInferior = (x * 8) - 4
			const limiteSuperior = (x * 8) + 4
			posX > limiteInferior and posX < limiteSuperior
		}))
		
		if(obj.estaEnPista())
			self.buscarAutos(obj.columnaNeta())
		else if(obj.estaEnAgua())
			self.buscarEnAgua(obj.columnaNeta())
	}
	
	method buscarAutos(columna){self.buscarObjetos(columna, "Auto")}
	
	method buscarEnAgua(columna){self.buscarObjetos(columna, "Obj Marino")}
	
	method buscarObjetos(xEnNeto, tipoObjeto){
		const _xEnBruto = xEnNeto * 8
		
		const hizoContacto = self.contactaObjeto(_xEnBruto)
		
		if(not hizoContacto)
			config.objPrincipal().contactos("")
	}
	
	method contactaObjeto(xEnBruto) {
		
		var hizoContacto = false
		const yEnColumnaActual = new Range(start = 0, end = background.limite_y())
		
		yEnColumnaActual.forEach({ y =>
			
			const pos = new Position(x = xEnBruto, y = y)
			const _contactos = game.getObjectsIn(pos)
			if(_contactos.size() > 0){
				_contactos.forEach({obj =>
					//Tiene que verificarse si el resultado de "verificarContacto" es true
					//antes de la función "ejecutarContacto" (por ej. todos los escenarios
					//Devuelven false en verificarContacto porque no tienen un método llamado
					//"ejecutarContacto")
					if(obj.verificarContacto(config.objPrincipal().position())){
						obj.ejecutarContacto()	
						hizoContacto = true				
					}
				})
			}
		})
		
		return hizoContacto
	}
}
