import wollok.game.*
import cosas.*
/***************************************************************************************************/
/*  LO HICE MÁS ABAJO COMO UN OBJETO QUE HEREDA DE LA CLASE "PERSONAJES" PARA NO REPETIR CÓDIGO

 	object personaje {
	var property vida = 0
	var property armadura = 0
	var property danio = 0
	var cosas = #{}
	
	var property position = (game.at(0,0))
	//var property image = "	" //agregar imagen
	
	method hayCosa() = game.getObjectsIn(self.position()).size() >= 2
	
	method agarra(cosasTiradas){
		if(not cosasTiradas.isEmpty())
		cosas.add(cosasTiradas.first())
		cosasTiradas.first().teAgarro(self)
	}
	
	method agregarArmadura(_armadura){
		armadura += _armadura
	}
	
	method agregarVida(_vida){
		vida += _vida
	}
	
	method agregarDanio(_danio){
		danio += _danio
	}
}

*/


/***************************************************************************************************/
class Personaje{
	var property vida
	var property armadura
	var property danio
	var property position //= (game.at(9,9)) //ver tamaño del mapa
	var property image //= "pepita1.png" //agregar imagen
	
	method hayCosa() = game.getObjectsIn(self.position()).size() == 2
	
	method agarra(cosa){
		if (self.hayCosa()) {
			cosa.teAgarro(self)
		}	
	}
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}	
	
/***************************************	REVEER  
*		method perseguiA(alguien){
*		if(self.position().x() > alguien.position().x()){
*			self.move(self.position().left(1))
*		}
*		if(self.position().x() < alguien.position().x()){
*			self.move(self.position().right(1))	
*		}
*		if(self.position().y() > alguien.position().y()){
*		self.move(self.position().down(1))
*		}
*		if(self.position().y() < alguien.position().y()){
*			self.move(self.position().up(1))	
*		}
*	}
****************************************************/
	
	
	method agregarArmadura(_armadura){
		armadura += _armadura
	}
	
	method agregarVida(_vida){
		vida += _vida
	}
	
	method agregarDanio(_danio){
		danio += _danio
	}
}


/***************************************************************************************************/

class Principal inherits Personaje{
	
}

/***************************************************************************************************/

class Enemigo inherits Personaje{
	
}
