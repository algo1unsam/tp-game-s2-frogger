import wollok.game.*
import objetosMoviles.*
import background.*
import config.*

class Tortuga inherits ObjetoMovilMarino{
	
	var etapa = 0
	var property tope = false
	
	override method altura() = 2
	
	override method velocidad() = 200
	
	override method mover(){
		position = self.position().down(1)
		self.etapas()
		self.limiteEtapas()
		self.valPosicion()
		
		if(self.contactaObjPrincipal()){
			const objPrincipal = config.objPrincipal()
			const nuevaPos = new Position(x = objPrincipal.position().x(), y = objPrincipal.position().down(1).y())
			objPrincipal.position(nuevaPos)
			
			if(objPrincipal.position().y() < 0)
				self.sacarSuperficieMarina(objPrincipal)
		}
	}
	

	method valPosicion(){
		if ((self.position().y() + self.altura()) < -2)
			position = new Position(x = x_real, y = (background.limite_y() - background.tamanio_celda()))
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
	
	override method verificarContacto(posicion){
		const mitad_de_altura = self.altura().div(2) + 1
		const topeInferior = self.position().y() - mitad_de_altura
		const topeSuperior = self.position().y() + mitad_de_altura
		const haceContacto = ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
		
		if(not haceContacto and self.contactaObjPrincipal())
			self.sacarSuperficieMarina(config.objPrincipal())
		
		return haceContacto
	}
	
	override method ejecutarContacto(){

		const objPrincipal = config.objPrincipal()
		
		if(self.abajoAgua())
			self.sacarSuperficieMarina(objPrincipal)
		else
			self.darSuperficieMarina(objPrincipal)

	}
	
}