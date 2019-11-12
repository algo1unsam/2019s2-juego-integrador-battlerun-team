import wollok.game.*
import cosas.*
import hud.*


/***************************************************************************************************/
class Personaje{
	var property vida
	var property armadura
	var property danio
	var property position
	var property image 
	var property estoyMuerto = 0	//Esta var sirve de flag para que no haga ciertas cosas estando muerto
	//PARA VER SI ES EL PERSONAJE PRINCIPAL O UN ENEMIGO
	method soyNPC() = true
	
	method esAtravesable() = true
	
	method hayCosa() = game.getObjectsIn(self.position()).size() == 2
	
	//METODO PARA EL PRINCIPAL
	method abri(puerta){}
	
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
	
	
	method teMataron(){
		self.estoyMuerto(1)
		game.removeVisual(self)
		if(self.soyNPC()){
			game.removeTickEvent( self.identity().toString() + "Golpea")
			game.removeTickEvent( self.identity().toString() + "Persigue")
		}
	}
	
	//Método que se llama en un onCollideDo (ver .wpgm) cuando el ENEMIGO choca con algo. Cuando el "algo" es el principal, el enemigo lo ataca.
	method teChoco(alguien){
		if(alguien.estoyMuerto() == 0) self.teAtaco(alguien)
	}
	
		
	method danioRecibidoPor(alguien) = if((alguien.danio() - armadura * 0.1) >= 0) alguien.danio() - armadura * 0.1 else 0
	
	method teAtaco(alguien){
		if (self.danioRecibidoPor(alguien) > 0) vida -= self.danioRecibidoPor(alguien)
		if (vida <= 0) self.teMataron()
	}
}


/***************************************************************************************************/

class Principal inherits Personaje{
	var puedoAtacar = 1 // Esta variable se usa de flag para un schedule en self.atacaA para no poder atacar muchas veces en poco tiempo
	var property coraHud = corazon
	var property armorHud = armor
	var property espadaHud = espada
	var property inventarioHud = _inventario
	var property inventario = []
	override method soyNPC() = false
	
	//Con este metodo abrimos la puerta final
	override method abri(puerta){
		puerta.teAbrio(self)
	}
	
	override method agregarVida(_vida){
		super(_vida)
		coraHud.agregoCorazon(self)
		
	}
	override method agregarArmadura(_armadura){
		super(_armadura)
		armorHud.agregoArmadura(self)
		_inventario.agregoInventario(self)
	}
	override method agregarDanio(_danio){
		super(_danio)
		espadaHud.agregoEspada(self)
		_inventario.agregoInventario(self)
	}
	
	override method teChoco(alguien){
		coraHud.conteoDeCorazones(coraHud.cantidadDeCorazones(self))
		super(alguien)
		if(coraHud.conteoDeCorazones()>coraHud.cantidadDeCorazones(self)){
			coraHud.remuevoCorazon(self)
		}
		
	}
	//Paso intermedio hacia ".teAtaco(self)" para que sea mas legible y se agregan unas condiciones de ataque
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
	
	var property inventario = [] // no tiene uso pero es necesario para no romper polimorfimo 
	
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
