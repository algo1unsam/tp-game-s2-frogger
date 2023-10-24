import wollok.game.*
import rana.*
import escenario.*

object config {
	const objPrincipal = rana
	var property nivelActual
	
	method iniciar(){
		self.movimiento()
		self.colisiones()
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
