import wollok.game.*
import background.*

class ObjetoMovil {
	//La grilla es de 9 (alto) por 15 (ancho: 0 - 14)
	//Los valores de X e Y corresponden al valor en "neto" en la grilla
	//O sea, su posición sin importar el tamaño de la celda. El cálculo se hace automático.
	const property x
	const property y
	
	const property x_real = x * background.tamanio_celda()
	const property y_real = y * background.tamanio_celda()
	
	var property position = new Position(x = x_real, y = y_real)
	
	//Con esto podemos evaluar si se está o no haciendo contacto
	const property altura = 6
	
	//En milisegundos, ver qué velocidad le conviene a cada obj
	method velocidad() = 1000
	
	//Para el caso de la tortuga, se debe sobrescribir con override como "false"
	method esMortal() = true 
	
	//Se puede sobrescribir para que el obj vaya a la izquierda, deberían invertir las imágenes
	//Cuando creen el objeto pueden crearlo por ejemplo: new Tortuga().moverse()
	method iniciar(){
		game.addVisual(self)
		game.onTick(self.velocidad(), "movimiento", {self.mover()})
	}
	
	method mover()
	
	//Este método se va a llamar cuando la rana toque al objeto
	method verificarContacto(posicion) {
		
		const mitad_de_altura = self.altura().div(2) + 1
		const topeInferior = self.position().y() - mitad_de_altura
		const topeSuperior = self.position().y() + mitad_de_altura
		
		return ((posicion.y() >= topeInferior) and (posicion.y() <= topeSuperior))
		
	}
	
	//Método al que se llama si hace contacto
	method ejecutarContacto()
	
}
