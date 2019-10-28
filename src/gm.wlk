import cosas.*
import wollok.game.*


class Marco {
	const verticeInicial
	const verticeFinal
	const image
	
	method dibujar() {
		self.dibujarLineaVertical(verticeInicial.x(),verticeInicial.y(),verticeFinal.y())
		self.dibujarLineaVertical(verticeFinal.x(),verticeInicial.y(),verticeFinal.y())
		self.dibujarLineaHorizontal(verticeInicial.y(),verticeInicial.x()+1,verticeFinal.x()-1)
		self.dibujarLineaHorizontal(verticeFinal.y(),verticeInicial.x()+1,verticeFinal.x()-1)

	}
	method dibujarElemento(columna,fila) {
		var elemento = new Obstaculo(
			image = image, 
			position = new Position(x=columna,y=fila) )
		game.addVisual(elemento)
	}
	
	method dibujarLineaVertical(columna,filaDesde,filaHasta){
		(filaDesde..filaHasta).forEach{fila=>self.dibujarElemento(columna,fila)}
	}
	method dibujarLineaHorizontal(fila,columnaDesde,columnaHasta){
		(columnaDesde..columnaHasta).forEach{columna=>self.dibujarElemento(columna,fila)}
	}
	
}