import wollok.game.*
import niveles.*
import config.*
import objetosInmoviles.*
import background.*

object menuPrincipal {
	
	var property nivelSeleccionado
	
	method mostrar() {
		self.nivelSeleccionado(config.nivelesDesbloqueados().size())
		game.boardGround("Menu/MenuPrincipal.png")
		game.addVisual(botonNivel)
	}
	
	method desplazarANivelDeIzquierda(){
		
		const cantidadNiveles = config.nivelesDesbloqueados().size()
		
		if(cantidadNiveles > 1){
			if(nivelSeleccionado == 1)
				nivelSeleccionado = config.nivelesDesbloqueados().size()
			else
				nivelSeleccionado--
		}
	}
	
	method desplazarANivelDeDerecha(){
		
		const cantidadNiveles = config.nivelesDesbloqueados().size()
		
		if(cantidadNiveles > 1){
			if(nivelSeleccionado == config.nivelesDesbloqueados().size())
				nivelSeleccionado = 1
			else
				nivelSeleccionado++
		}
	}
	
	method seleccionarNivel(nroNivel){
		
		game.removeVisual(botonNivel)
		
		var nivel
		if(nroNivel == 1)
			nivel = new Nivel1()
		if(nroNivel == 2)
			nivel = new Nivel2()
		if(nroNivel == 3)
			nivel = new Nivel3()
		if(nroNivel == 4)
			nivel = new Nivel4()
		
		config.iniciar(nivel)
			
	}
	
}

object botonNivel{
	
	method conFlechas() = config.nivelesDesbloqueados().size() > 1
	method inicioDeRuta() = if(self.conFlechas()) "assets/Menu/Botones/BotonFlechas-Nivel" else "assets/Menu/Botones/Boton-Nivel"
	method image() =  self.inicioDeRuta() + menuPrincipal.nivelSeleccionado().toString() + ".png"
	method position() = game.at(background.limite_x().div(2) - 13, 8)

}