import wollok.game.*
import personajes.*


class Cosa{
	var property position 
	method esAtravesable()=true
	//paso intermedio para que sea mas legible. Cuando chocan una cosa, siempre la agarran.
	method teChoco(alguien){
		if(alguien.estoyMuerto() == 0) self.teAgarro(alguien)
	}
	
	//Método para que sea todo más polimórfico, no hace nada en el caso de las "cosas"
	method teAtaco(alguien){}
	
	//Mirar bien como funciona el lookUp
	//Todos los items, cuando son agarrados, hacen algo y despues se van del mapa. Acá sólo está esa segunda parte (porque es comun a todos)
	method teAgarro(alguien){
		game.removeVisual(self)
	}
	
	method teAbrio(alguien){}
}


/***************************************************************************************************/
class Armadura inherits Cosa{
	var property armadura = 20
	var property image = "armadura.png"
	
	override method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		super(alguien)
	}
}


/***************************************************************************************************/
class Casco inherits Cosa{
	var property armadura = 5
	var property image = "casco.png"
	
	override method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		super(alguien)
	}
}


/***************************************************************************************************/
class Escudo inherits Cosa{
	var property armadura = 15
	var property image = "escudo_madera.png"
	
	override method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		super(alguien)
	}
}


/***************************************************************************************************/
class Botas inherits Cosa{
	var property armadura = 5
	var property image = "armadura.png"
	
	override method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		super(alguien)
	}
}



/***************************************************************************************************/
class Daga inherits Cosa{
	var property danio = 15
	var property image = "daga.png"
	
	override method teAgarro(alguien){
		alguien.agregarDanio(danio)
		super(alguien)
	}
}


/***************************************************************************************************/
class Espada inherits Cosa{
	var property danio = 35
	var property image = "espada.png"
	
	override method teAgarro(alguien){
		alguien.agregarDanio(danio)
		super(alguien)
	}
}


/***************************************************************************************************/
class Sable inherits Cosa{
	var property danio = 45
	var property image = "sable.png"
	
	override method teAgarro(alguien){
		alguien.agregarDanio(danio)
		super(alguien)
	}
}



/***************************************************************************************************/
class Pocion inherits Cosa{
	var property vida = 250
	var property image = "pota.png"
	
	override method teAgarro(alguien){
		alguien.agregarVida(vida)
		super(alguien)
	}
}


/***************************************************************************************************/
class Obstaculo{
	
	var property position = game.origin()
	var property image
	
	//a traves de este metodo es el ue vamos a validar si el objeto "choca" o no.-
	
	method esAtravesable() = false
	
}


/***************************************************************************************************/
class Puerta inherits Cosa{

	var property estoyAbierta = false
	var property image = "puerta.png"
	
	override method teAgarro(alguien){}
	
	override method teAbrio(personaje){
		self.estoyAbierta(true)
	}
	
}


/***************************************************************************************************/
class CorazonHud{
	var property position
	var property vidaQueRepresenta
	var property image = "peach.png"      //agregar asset
	var property esAtravesable = false	
	
	method desaparezco(personaje){      //problema, una vez que el corazon desaparece el bloque vuelve a ser atavesable
		if(personaje.vida()<vidaQueRepresenta){
			game.removeVisual(self)
			game.removeTickEvent(self.identity().toString() +"vida")
		}	
	}
	
	
}


/***************************************************************************************************/
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