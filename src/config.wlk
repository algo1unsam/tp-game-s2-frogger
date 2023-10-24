import wollok.game.*
import rana.*
import escenario.*

object posXRana{
	method position() = game.at(0,0)
	method text() = "X: " + rana.position().x().toString()
}

object posYRana{
	method position() = game.at(0,8)
	method text() = "Y: " + rana.position().y().toString()
}

object config {
	const property objPrincipal = rana
	var property nivelActual
	
	method iniciar(){
		self.movimiento()
		self.colisiones()
		game.addVisual(posXRana)
		game.addVisual(posYRana)
		game.onTick(100,"Validar",{objPrincipal.validarTerreno()})
	}
	
	method colisiones(){

	}
	
	//La idea es verificar que en el terreno no hay un arbusto, por ejemplo
	//Si hay un arbusto o si es el limite de la pantalla, entonces se anula la función
	//Fijate que en el objeto rana, en el metodo validarTerreno
	//muestro una forma de verificar que una coordenada pertenece a un escenario
	//El terreno está dispuesto a lo largo de las X asi que solamente tenés que verificar que
	//La coordenada X está entre alguno de las coordenadas X de los arbustos dispuestos y
	//7 unidades más para cada una de esas coordenadas. Avisame si no se entiende pero creo
	//Que mirando el codigo de la funcion que te menciono lo vas a entender
	method verificarPosicion(posicion){
		
	}
	
	method moverObjPrincipal(strDireccion){
		
		var rutaImagen
		
		rutaImagen  = "assets/" + objPrincipal.nombreAssets() + "/"
		rutaImagen += strDireccion + "/" + objPrincipal.nombreAssets() + "-" + strDireccion
		rutaImagen += objPrincipal.estadoParaImg().toString() + ".png"
		
		objPrincipal.image(rutaImagen)
		objPrincipal.mover(strDireccion)
	}
	
	method moverIzquierda() {self.moverObjPrincipal("Izquierda")}
	
	method moverDerecha() {self.moverObjPrincipal("Derecha")}
	
	method moverArriba() {self.moverObjPrincipal("Arriba")}
	
	method moverAbajo() {self.moverObjPrincipal("Abajo")}
	
	
	method movimiento(){
		
		keyboard.up().onPressDo({self.moverArriba()})
		
		keyboard.down().onPressDo({self.moverAbajo()})
	
		keyboard.left().onPressDo({self.moverIzquierda()})
	
		keyboard.right().onPressDo({self.moverDerecha()})
		
	}
}
