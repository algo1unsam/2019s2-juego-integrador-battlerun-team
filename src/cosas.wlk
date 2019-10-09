import wollok.game.*
import personajes.*

/***************************************************************************************************/
class Armadura{
	var property armadura = 10
	var property image = "armadura.png" // poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teChoco(alguien){
		alguien.agregarArmadura(armadura)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Danio{
	var property danio = 10
	var property image = "daga.png" // poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teChoco(alguien){
		alguien.agregarDanio(danio)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Vida{
	var property vida = 10
	var property image = "pocion.png" //poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teChoco(alguien){
		alguien.agregarVida(vida)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Obstaculo{
	//var property image = "	" //poner imagen
	var property position // se la asignamos
}