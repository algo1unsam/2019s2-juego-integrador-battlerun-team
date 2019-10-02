import wollok.game.*
import personajes.*

/***************************************************************************************************/
class Armadura{
	var property armadura = 10
	var property image = "manzana.png" // poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teAgarro(alguien){
		alguien.agregarArmadura(armadura)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Danio{
	var property danio = 10
	var property image = "alpiste.png" // poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teAgarro(alguien){
		alguien.agregarDanio(danio)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Vida{
	var property vida = 10
	var property image = "ciudad.png" //poner imagen
	var property position = (game.at(0.randomUpTo(9), 0.randomUpTo(9))) // VER TAMAÑO DEL MAPA
	
	method teAgarro(alguien){
		alguien.agregarVida(vida)
		game.removeVisual(self)
	}
}


/***************************************************************************************************/
class Obstaculo{
	//var property image = "	" //poner imagen
	var property position // se la asignamos
}