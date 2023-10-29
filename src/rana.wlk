import wollok.game.*
import config.*
import background.*

object rana{
	const property positionInicial = game.at(0,16)
	const property nombreAssets = "Rana"
	var property estadoParaImg = 1
	var property position = self.positionInicial()
	var property puntaje = 0
	var property vidas = 5
	var property image = "assets/Rana/Derecha/Rana-Derecha1.png"
	var estaEnAgua = false
	var estaEnPista = false
	var property velocidad = 4
	
	method arriba() {
		if(self.position().y() >= (game.height() - 8))
			return false
			
		const X = self.position().x()
		const nuevaY = self.position().y() + self.velocidad()
		const nuevaPos = new Position(x = X, y = nuevaY)
		position = nuevaPos
		return true
	}
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
	}

	method validarTerreno(){
		
		const pistasEnTerreno = config.nivelActual().columnasDePista()
		const aguasEnTerreno = config.nivelActual().columnasDeAgua()
		const posX = self.position().x().div(8)
		
		estaEnPista = pistasEnTerreno.any({x => posX >= x and posX <= (x + 1)})
		estaEnAgua = aguasEnTerreno.any({x => posX >= x and posX <= (x + 1)})
		
		if(estaEnPista)
			game.say(self,"pista")
		//Aplicar la misma logica para el agua
	}
	
	method buscarAutos(x){
		new Range(start = 0, end = background.limite_y()).forEach({ y =>
			game.getObjectsIn(new Position(x = x, y = y)).forEach({obj =>
				obj.Contacto(self.position())
			})
		})
	}
	
	method sumarEtapas() {
		self.validarEtapa()
		estadoParaImg++
	}
	
	method validarEtapa() {
		if(self.estadoParaImg() == 7) {
			estadoParaImg = 0
		}
	}
	method mover(direccion){
		
		self.sumarEtapas()
		direccion.mover(self)
	}
	
	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
	method Contacto(posicion){}
	
}

object arriba{
	
	const property nombre = "Arriba"
	
	method mover(obj){
		if(obj.position().y() < (game.height() - 8)){
			//if(objetoPrincipal.position().y() > 50)
			//objetoPrincipal.position().up(20)
			obj.arriba()
			return true
		}
		return false
	}
}

object abajo{
	const property nombre = "Abajo"
	
	method mover(objetoPrincipal){
		if(objetoPrincipal.position().y() > 0){
			objetoPrincipal.position(objetoPrincipal.position().down(objetoPrincipal.velocidad()))
		}
		return true
	}
}
object izquierda{
	const property nombre = "Izquierda"
	
	method mover(objetoPrincipal){
		if(objetoPrincipal.position().x() > 0){
			objetoPrincipal.position(objetoPrincipal.position().left(objetoPrincipal.velocidad()))
		}
		return true
	}
}
object derecha{
	const property nombre = "Derecha"
	
	method mover(objetoPrincipal){
		if(objetoPrincipal.position().x() < background.limite_x() - 8){
			objetoPrincipal.position(objetoPrincipal.position().right(objetoPrincipal.velocidad()))
		}
		return true
	}
}
	

