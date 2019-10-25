import wollok.game.*
import cosas.*


/***************************************************************************************************/
class Personaje{
	var property vida
	var property armadura
	var property danio
	var property position
	var property image 
	var property estoyMuerto = 0	//Esta var sirve de flag para que no haga ciertas cosas estando muerto
	
	method esAtravesable() = true
	method hayCosa() = game.getObjectsIn(self.position()).size() == 2
	
	
	method move(nuevaPosicion) {
		if(game.getObjectsIn(nuevaPosicion).all{objeto => objeto.esAtravesable()}){  //No muy optimo, pero bueno no se me ocurrio otra forma
		self.position(nuevaPosicion)
		}
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
		self.estoyMuerto(1)
		game.removeVisual(self)
		game.removeTickEvent( self.identity().toString() + "Golpea")
		game.removeTickEvent( self.identity().toString() + "Persigue")
		//game.end()
	}
	
	//Método que se llama en un onCollideDo (ver .wpgm) cuando el ENEMIGO choca con algo. Cuando el "algo" es el principal, el enemigo lo ataca.
	method teChoco(alguien){
		if(alguien.estoyMuerto() == 0) self.teAtaco(alguien)
	}
	
	method danioRecibidoPor(alguien) = alguien.danio() - armadura
	
	method teAtaco(alguien){
		if (self.danioRecibidoPor(alguien) > 0) vida -= self.danioRecibidoPor(alguien)
		if (vida <= 0) self.teMataron()
	}
}


/***************************************************************************************************/

class Principal inherits Personaje{
	var puedoAtacar = 1 // Esta variable se usa de flag para un schedule en self.atacaA para no poder atacar muchas veces en poco tiempo
	
	//El "teAgarro(self)" es un paso intermedio (no hace absolutamente nada) que sirve para que sea más intuitivo a la hora de leer el codigo
	//El método es activado al presionar la "a" (ver el .wpgm) y lo que hace es sumar la cosa sobre la que esta parado a su inventario. Si es el enemigo, no hace nada.
	method agarraA(unaCosa){
		if (self.hayCosa()) {
			unaCosa.teAgarro(self)
		}	
	}
	
	//Acá lo mismo que arriba, está este paso intermedio "teAtaco(self)" para que sea mas legible
	//Con la tecla "x" (ver .wpgm) el personaje ataca al enemigo (tienen que estar en la misma posicion) si hay cualquier otra cosa que no sea el enemigo no hace nada
	//Solo se puede atacar una vez cada 350ms, para que sea más parejo 
	method atacaA(alguien){
		if(puedoAtacar == 1){
			alguien.teAtaco(self)
			puedoAtacar = 0
			game.schedule(350, {=> puedoAtacar = 1} )
		}
	}
}

/***************************************************************************************************/

class Enemigo inherits Personaje{
	
	//Método hecho para más polimorfismo y que no se rompa todo, sirve para agarrar cosas. En este caso no hace nada
	method teAgarro(alguien){}
	
	
	/***************************************	REVEER  
	Son muchos if. De todas formas funciona y las 4 comparaciones son necesarias, así que creo que está bien
	*/
	method perseguiA(alguien){
			if(self.position().x() > alguien.position().x()){
				self.move(self.position().left(1))
			} 	else { 	if(self.position().y() > alguien.position().y()){
						self.move(self.position().down(1))
						}
						else { 	if(self.position().x() < alguien.position().x()){
								self.move(self.position().right(1))	
								}	
								else {	if(self.position().y() < alguien.position().y()){
										self.move(self.position().up(1))	
										}	
								}
						}		
				}
	}
}
