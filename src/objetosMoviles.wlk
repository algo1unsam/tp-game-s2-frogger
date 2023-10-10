import wollok.game.*

class ObjetoMovil {
	//Todos deben tener position porque se tienen que ir desplazando
	//(si se excede del límite de pantalla deben aparecer por el otro lado o hay que implementar alguna lógica
	//para evitar crear infinitos objetos, se podría destruir con "removeVisual" cuando se excede de los límites de pantalla)
	//Habría que averiguarlo
	var property position
	
	//En milisegundos, ver qué velocidad le conviene a cada obj
	method velocidad() = 1000
	
	//Para el caso de la tortuga, se debe sobrescribir con override como "false"
	method esMortal() = true 
	
	//Se puede sobrescribir para que el obj vaya a la izquierda, deberían invertir las imágenes
	//Cuando creen el objeto pueden crearlo por ejemplo: new Tortuga().moverse()
	method moverse() = game.onTick(self.velocidad(), "movimiento", {self.position().right(1)})
	
	//Este método se va a llamar cuando la rana toque al objeto
	method Contacto()
	
}