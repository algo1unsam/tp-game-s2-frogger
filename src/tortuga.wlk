import wollok.game.*
import objetosMoviles.*
import background.*
import rana.*

class Tortuga inherits ObjetoMovil{
	
	var etapa = 0
	var property tope = false
	
	override method altura() = 10
	
	override method velocidad() = 200
	
	override method esMortal() = self.abajoAgua()
	
	override method mover(){
		position = self.position().down(1)
		self.etapas()
		self.limiteEtapas()
		self.valPosicion()
	}
	

	method valPosicion(){
		if (self.position().y() < 0){
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
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
	
	
	override method ejecutarContacto(){

	}
	
}