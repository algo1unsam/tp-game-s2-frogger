import wollok.game.*
import niveles.*
import config.*
import objetosInmoviles.*

object menuPrincipal {
	
	var property nivelSeleccionado = 1
	
	method mostrar() {
		game.boardGround("Menu/MenuPrincipal.png")
		config.configTeclas()
	}
	
	method desplazarANivelDeIzquierda(){
		if(cartelDerecha.visible()){
			game.removeVisual(cartelDerecha)
			cartelDerecha.visible(false)
		}
		
		if(not cartelIzquierda.visible()){
			cartelIzquierda.visible(true)
			game.addVisual(cartelIzquierda)
		}
	}
	
	method desplazarANivelDeDerecha(){
		if(cartelIzquierda.visible()){
			game.removeVisual(cartelIzquierda)
			cartelIzquierda.visible(false)
		}
		
		if(not cartelDerecha.visible()){
			cartelDerecha.visible(true)
			game.addVisual(cartelDerecha)
		}
	}
	
	method seleccionarNivel(nroNivel){
		var nivel
		if(nroNivel == 1)
			nivel = new Nivel1()
		//if(nroNivel == 2)
		//	nivel = new Nivel2()
		//if(nroNivel == 3)
		//	nivel = new Nivel3()
		//if(nroNivel == 4)
		//	nivel = new Nivel4()
		
		config.iniciar(nivel)
			
	}
	
}

object cartelDerecha{
	var property visible = false
	method text() = "Desplazaste a derecha"
	method textColor() = "FFFFFFFF"
	method position() = game.at(30,16)
}

object cartelIzquierda{
	var property visible = false
	method text() = "Desplazaste a izquierda"
	method textColor() = "FFFFFFFF"
	method position() = game.at(30,16)
}
