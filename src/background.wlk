import wollok.game.*
import escenario.*

object background {
	
	//****************
	//DATOS DE GRILLA
	//****************
	//Eje x = 15 columnas usables
	//Eje y = 9 filas usables. Una décima fila se usa para barra de estado (tiempo, vidas...)
	
	const property limite_y = 64
	const property limite_x = 80
	const property tamanio_celda = 8
	const property columna_de_meta = limite_x - tamanio_celda
	const property eje_x = new Range(start = 0, end = limite_x, step = 8)
	const property eje_y = new Range(start = 0, end = (limite_y - 1), step = 8)
	
	
}