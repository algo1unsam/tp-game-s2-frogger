import objetosMoviles.*

class Tortuga inherits ObjetoMovil{
	
	var etapa = 0
	var property tope = false
	
	override method velocidad() = 200
	
	override method esMortal() = self.abajoAgua()
	
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