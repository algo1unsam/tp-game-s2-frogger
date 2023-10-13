import wollok.game.*

class ObjetoMovil {
	//Todos deben tener position porque se tienen que ir desplazando
	//(si se excede del límite de pantalla deben aparecer por el otro lado o hay que implementar alguna lógica
	//para evitar crear infinitos objetos, se podría destruir con "removeVisual" cuando se excede de los límites de pantalla)
	//Habría que averiguarlo
	var property positionInicial
	var property position = self.positionInicial()
	
	//En milisegundos, ver qué velocidad le conviene a cada obj
	method velocidad() = 1000
	
	//Para el caso de la tortuga, se debe sobrescribir con override como "false"
	method esMortal() = true 
	
	//Se puede sobrescribir para que el obj vaya a la izquierda, deberían invertir las imágenes
	//Cuando creen el objeto pueden crearlo por ejemplo: new Tortuga().moverse()
	method iniciar(){
		position = self.positionInicial()
		game.onTick(self.velocidad(), "movimiento", {self.mover()})
		}
	
	method mover()
	
	//Este método se va a llamar cuando la rana toque al objeto
	method Contacto()
	
}

class Tortuga inherits ObjetoMovil{
	
	var etapa = 0
	var property tope = false
	
	override method velocidad() = 500
	
	override method esMortal() = false
	
	override method mover(){
		position = position.right(1)
		self.etapas()
		self.limiteEtapas()
		self.valPosicion()
	}
	
	method valPosicion(){
		if (self.position().x()>80){
			position = self.positionInicial()
			
			}
	}
	
	method limiteEtapas(){
		if (etapa == 14){tope = true}
		else if (etapa == 0) {tope = false}
	}
	
	method etapas(){
		if(self.tope()){etapa -=1}
    	else {etapa += 1}
	}
	
	method image(){
		if (self.abajoAgua()){
			return "tortuga/Vacio.png"
		}
		else {return "tortuga/Tortuga"+etapa.toString()+".png"}
	}
	
	method abajoAgua() = etapa > 9 and etapa < 15
	
	override method Contacto(){}
	
}