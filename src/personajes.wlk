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
	var property position
	var property image 
	
	
	
	method hayCosa() = game.getObjectsIn(self.position()).size() == 2
	
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
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
	
	
	//Hay que definir qué más pasa cuando se muere cada uno. (puede morir el principal o el enemigo) 
	method teMataron(){
		game.removeVisual(self)
		//game.end()
	}
	
	//Método que se llama en un onCollideDo (ver .wpgm) cuando el ENEMIGO choca con algo. Cuando el "algo" es el principal, el enemigo lo ataca.
	method teChoco(alguien){
		self.teAtaco(alguien)
	}
	
	method teAtaco(alguien){
		vida -= (alguien.danio() - armadura)
		if (vida < 0) self.teMataron()
	}
}


/***************************************************************************************************/

class Principal inherits Personaje{
	
	
	//El "teAgarro(self)" es un paso intermedio (no hace absolutamente nada) que sirve para que sea más intuitivo a la hora de leer el codigo
	//El método es activado al presionar la "a" (ver el .wpgm) y lo que hace es sumar la cosa sobre la que esta parado a su inventario. Si es el enemigo, no hace nada.
	method agarraA(unaCosa){
		if (self.hayCosa()) {
			unaCosa.teAgarro(self)
		}	
	}
	
	//Acá lo mismo que arriba, está este paso intermedio "teAtaco(self)" para que sea mas legible
	//Con la tecla "x" (ver .wpgm) el personaje ataca al enemigo (tienen que estar en la misma posicion) si hay cualquier otra cosa que no sea el enemigo no hace nada
	method atacaA(alguien){
		alguien.teAtaco(self)
	}
	
}

/***************************************************************************************************/

class Enemigo inherits Personaje{
	
	//Método hecho para más polimorfismo y que no se rompa todo, sirve para agarrar cosas. En este caso no hace nada
	method teAgarro(alguien){}
	
	
/***************************************	REVEER  
Se mueve en diagonal y son muchos if. De todas formas funciona y las 4 comparaciones son necesarias, así que creo que está bien
*/
method perseguiA(alguien){
		if(self.position().x() > alguien.position().x()){
			self.move(self.position().left(1))
		}
		if(self.position().x() < alguien.position().x()){
			self.move(self.position().right(1))	
		}
		if(self.position().y() > alguien.position().y()){
		self.move(self.position().down(1))
		}
		if(self.position().y() < alguien.position().y()){
			self.move(self.position().up(1))	
		}
	}
	
	
}
