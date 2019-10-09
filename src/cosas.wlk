import wollok.game.*
import personajes.*


class Cosa{
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9)))
	
	//paso intermedio para que sea mas legible. Cuando chocan una cosa, siempre la agarran.
	method teChoco(alguien){
		self.teAgarro(alguien)
	}
	
	//Método para que sea todo más polimórfico, no hace nada en el caso de las "cosas"
	method teAtaco(alguien){}
	
	//Mirar bien como funciona el lookUp
	//Todos los items, cuando son agarrados, hacen algo y despues se van del mapa. Acá sólo está esa segunda parte (porque es comun a todos)
	method teAgarro(alguien){
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Armadura inherits Cosa{
	var property armadura = 10
	var property image = "armadura.png"
	
	override method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		super(alguien)
	}
}


/***************************************************************************************************/
class Danio inherits Cosa{
	var property danio = 10
	var property image = "daga.png"
	
	override method teAgarro(alguien){
		alguien.agregarDanio(danio)
		super(alguien)
	}
}


/***************************************************************************************************/
class Vida inherits Cosa{
	var property vida = 10
	var property image = "pocion.png"
	
	override method teAgarro(alguien){
		alguien.agregarVida(vida)
		super(alguien)
	}
}


/***************************************************************************************************/
class Obstaculo{
	//var property image = "	" //poner imagen
	var property position // se la asignamos
}