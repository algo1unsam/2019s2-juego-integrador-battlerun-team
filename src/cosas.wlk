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
	
	method posHud() = game.at(23,15)
	
	override method teAgarro(alguien){
		super(alguien)
		var armor = new Armadura(position = self.posHud())
		alguien.inventario().add(armor)
		alguien.agregarArmadura(armadura)
	}
}


/***************************************************************************************************/
class Casco inherits Cosa{
	var property armadura = 5
	var property image = "casco.png"
	
	method posHud() = game.at(23,16)
	
	override method teAgarro(alguien){
		super(alguien)
		var casc = new Casco(position = self.posHud())
		alguien.inventario().add(casc)
		alguien.agregarArmadura(armadura)
	}
}


/***************************************************************************************************/
class Escudo inherits Cosa{
	var property armadura = 20
	var property image = "escudo_madera.png"
	
	method posHud() =game.at(24,13)
	
	override method teAgarro(alguien){
		super(alguien)
		var escu = new Escudo(position= self.posHud())
		alguien.inventario().add(escu)
		alguien.agregarArmadura(armadura)
	}
}


/***************************************************************************************************/
class Botas inherits Cosa{
	var property armadura = 5
	var property image = "botas.png"
	
	method posHud() = game.at(23,11)
	
	override method teAgarro(alguien){
		super(alguien)
		var bota = new Botas(position = self.posHud())
		alguien.inventario().add(bota)
		alguien.agregarArmadura(armadura)
	}
}



/***************************************************************************************************/
class Daga inherits Cosa{
	var property danio = 20
	var property image = "daga.png"
	
	method posHud() = game.at(22,13)
	override method teAgarro(alguien){
		super(alguien)
		var dag = new Daga(position = self.posHud())
		alguien.inventario().add(dag)
		alguien.agregarDanio(danio)
	}
}


/***************************************************************************************************/
class Espada inherits Cosa{
	var property danio = 25
	var property image = "espada.png"
	
	method posHud() =  game.at(22,13)
	override method teAgarro(alguien){
		super(alguien)
		var espa = new Espada(position = self.posHud())
		alguien.inventario().add(espa)
		alguien.agregarDanio(danio)
	}
}


/***************************************************************************************************/
class Sable inherits Cosa{
	var property danio = 30
	var property image = "sable.png"
	
	method posHud() =  game.at(22,13)
	override method teAgarro(alguien){
		super(alguien)
		var sabl = new Sable(position = self.posHud())
		alguien.inventario().add(sabl)
		alguien.agregarDanio(danio)
		
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