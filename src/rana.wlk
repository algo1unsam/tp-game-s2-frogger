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
	var property estaEnAgua = false
	var property estaEnPista = false
	var property velocidad = 1
	var property columnaNeta = 0
	var property contactos = ""
	
	
	method aumentar(valor){
		puntaje += valor
	}
	
	method iniciar(){
		game.addVisualCharacter(self)
	}

	method validarTerreno(){
		
		const pistasEnTerreno = config.nivelActual().columnasDePista()
		const aguasEnTerreno = config.nivelActual().columnasDeAgua()
		const posX = self.position().x()
		columnaNeta = (posX + 4).div(8)
		
		estaEnPista = pistasEnTerreno.any({x =>
			const limiteInferior = (x * 8) - 4
			const limiteSuperior = (x * 8) + 4
			posX >= limiteInferior and posX <= limiteSuperior
		})
		estaEnAgua = aguasEnTerreno.any({x => 
			const limiteInferior = (x * 8) - 4
			const limiteSuperior = (x * 8) + 4
			posX >= limiteInferior and posX <= limiteSuperior
		})
		
		if(estaEnPista)
			self.buscarAutos(columnaNeta)
		//Aplicar la misma logica para el agua
	}
	
	method buscarAutos(xEnNeto){
		const xEnBruto = xEnNeto * 8
		const estaTocandoUnAuto = self.haceContacto(xEnBruto)
		if(estaTocandoUnAuto)
			self.contactos("Auto")
		else
			self.contactos("")
	}
	
	method haceContacto(xEnBruto) =
		new Range(start = 0, end = background.limite_y()).any({ y =>
					(game.getObjectsIn(new Position(x = xEnBruto, y = y)).any({obj =>
						obj.Contacto(self.position())
					}))
				})
	
	method mover(direccion){  //objetpoos
		
		if(direccion == "Arriba")
			self.mover_arriba()
		else if(direccion == "Abajo")
			self.mover_abajo()
		else if(direccion == "Izquierda")
			self.mover_izquierda()
		else if(direccion == "Derecha")
			self.mover_derecha()
	}
	method mover_arriba(){self.position().up(velocidad)}
	method mover_abajo(){self.position().down(velocidad)}
	method mover_izquierda(){self.position().left(velocidad)}
	method mover_derecha(){self.position().right(velocidad)}
		
	
	method perderVida(){
		
		vidas -=1	
		if (vidas == 0)
			game.stop()
		self.position(self.positionInicial())
	}
	
	method Contacto(posicion){}
	
}
	

