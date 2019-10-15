import wollok.game.*
import personajes.*


class Cosa{
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9)))
	
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
	var property image = "escudo.png"
	
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
	var property vida = 50
	var property image = "pocion.png"
	
	override method teAgarro(alguien){
		alguien.agregarVida(vida)
		super(alguien)
	}
}


/***************************************************************************************************/
object obstaculo{
	
	method image() = "pared1.png"
	//a traves de este metodo es el ue vamos a validar si el objeto "choca" o no.-
	method esAtravesable() = false
	
}