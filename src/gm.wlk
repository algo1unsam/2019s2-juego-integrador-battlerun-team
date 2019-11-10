import cosas.*
import wollok.game.*
import personajes.*


class Nivel{
	const marcoGeneral = new Marco(verticeInicial= new Position(x=0,y=0), verticeFinal = new Position(x=22, y=11), image = "pared1.png")
	var property marcos = [marcoGeneral]
	var property enemigos = []
	var property items = []
	var property personajes = enemigos.copy() //A ESTE SE LE AGREGA EL PERSONAJE PRINCIPAL EN .setearTodo()
	
	method siguienteNivel()
	method agregarEnemigos()
	method agregarMarcos()
	method agregarItems()
	method setearEventos(principal)
	method piso()
	method superado()
	method nivelNumero(personaje)
	
	//PREGUNTO PARA VER QUE METODO LLAMAR CUANDO PASA DE NIVEL. SI ES FINAL -> nivel.terminarJuego()
	method esFinal() = false
	
	//AGREGA TODAS LAS VISUALES (MENOS EL PJ PRINCIPAL) EN EL MAPA
	method dibujarTodo(){
		enemigos.forEach({enemigo => game.addVisual(enemigo)})
		marcos.forEach({marco => marco.dibujar()})
		items.forEach({ item => game.addVisual(item)})		
	}
	
	//TODA LA CONFIG QUE TIENE QUE VER CON EL PERSONAJE PRINCIPAL + addVisual()
	method setearPrincipal(principal){
		game.addVisual(principal)
		
			// Movilidad del personaje (necesaria para que el objeto pueda ser "no atravesable")
		keyboard.up().onPressDo({ principal.move(principal.position().up(1)) })
		keyboard.down().onPressDo({ principal.move(principal.position().down(1)) })
		keyboard.left().onPressDo({ principal.move(principal.position().left(1)) })
		keyboard.right().onPressDo({ principal.move(principal.position().right(1)) })
		
			// CON LA LETRA A, EL PERSONAJE PRINCIPAL AGARRA LOS ITEMS. 
		keyboard.a().onPressDo({ game.colliders(principal).forEach({cosa => cosa.teAgarro(principal) }) })
	
			// CON LA LETRA X, EL PERSONAJE PRINCIPAL GOLPEA AL ENEMIGO.
		keyboard.x().onPressDo({ principal.atacaA(game.colliders(principal).first()) })
			
			// CON EL ENTER, EL PERSONAJE PRINCIPAL ABRE LAS PUERTAS
		keyboard.enter().onPressDo({ game.colliders(principal).forEach({ cosa => principal.abri(cosa)}) })
		
		
	}
	
	//PARA QUE LOS PERSONAJES DIGAN SUS ATRIBUTOS
	method setearBarra(){
		keyboard.space().onPressDo({ personajes.forEach({ personaje => if (personaje.estoyMuerto() == 0) game.say(personaje, "Vida: " + personaje.vida() + " Daño: " + personaje.danio()) }) })
	}
	
	//PARA EL CAMBIO DE FONDO (NO ANDA)
	method setearPiso(){
		game.ground(self.piso())
	}
	
	//METODO QUE SE LLAMA EN EL .wpgm PARA QUE SE CONFIGURE TODO
	method setearTodo(principal){
		personajes.add(principal)
		self.setearPrincipal(principal)
		self.setearBarra()
		self.setearPiso()
		self.agregarEnemigos()
		self.agregarMarcos()
		self.agregarItems()
		self.setearEventos(principal)
		self.dibujarTodo()
		self.nivelNumero(principal)
	}
	
	method terminarJuego(){
		game.schedule(3000, {=> game.stop()})
	}
}


/****************************************************************************************************************************************/

object nivel1 inherits Nivel{
	var insecto = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(5,9), image = "insecto.png")
	var orco = new Enemigo(vida = 150, armadura = 10, danio = 50, position = game.at(9,9), image = "orco.png") 
	var property puerta = new Puerta(posicion = game.at(4,2))
	
	override method piso() = "piso.png"
	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 1")
	}
	
	override method agregarEnemigos(){
		enemigos.add(insecto)
		enemigos.add(orco)
	}
	
	override method agregarMarcos(){
		//POR SI QUEREMOS HACER CELDAS
	}
	
	override method agregarItems(){
		items.add(new Pocion())
		items.add(new Espada())
		items.add(new Armadura())
		items.add(puerta)
	}
	
	
	override method setearEventos(principal){
	game.onTick(1100, orco.identity().toString() + "Persigue", {=> orco.perseguiA(principal)})
	game.onTick(800, insecto.identity().toString() + "Persigue", {=> insecto.perseguiA(principal)})
	
	game.onTick(500, orco.identity().toString() + "Golpea", {=> if(game.colliders(orco).size() > 0) game.colliders(orco).first().teChoco(orco)})
	game.onTick(500, insecto.identity().toString() +"Golpea", {=> if(game.colliders(insecto).size() > 0) game.colliders(insecto).first().teChoco(insecto)}) 
	}
	
	override method superado() = self.puerta().estoyAbierta()
	
	override method siguienteNivel() = nivel2
}


/****************************************************************************************************************************************/

object nivel2 inherits Nivel{
	var lobo = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(5,9), image = "lobo.png")
	var loboJefe = new Enemigo(vida = 50, armadura = 10, danio = 40, position = game.at(9,3), image = "lobo.png")
	var property puerta = new Puerta(posicion = game.at(1,1))
	
	override method piso() = "piso3.png"
	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 2")
	}
	
	override method agregarEnemigos(){
		enemigos.add(lobo)
		enemigos.add(loboJefe)
	}
	
	override method agregarMarcos(){
	}
	
	override method agregarItems(){
		items.add(new Pocion())
		items.add(new Pocion())
		items.add(new Pocion())
		items.add(new Espada())
		items.add(new Armadura())
		items.add(puerta)
	}
	
	override method setearEventos(principal){
		game.onTick(1000, lobo.identity().toString() + "Persigue", {=> lobo.perseguiA(principal)})
		game.onTick(1300, loboJefe.identity().toString() + "Persigue", {=> loboJefe.perseguiA(principal)})
	
		game.onTick(500, lobo.identity().toString() + "Golpea", {=> if(game.colliders(lobo).size() > 0) game.colliders(lobo).first().teChoco(lobo)})
		game.onTick(650, loboJefe.identity().toString() +"Golpea", {=> if(game.colliders(loboJefe).size() > 0) game.colliders(loboJefe).first().teChoco(loboJefe)}) 
	}
	
	override method superado() = self.puerta().estoyAbierta()

	override method siguienteNivel() = ganar
	
}


/****************************************************************************************************************************************/

object ganar{
	
	method esFinal() = true 
	
	method terminarJuego(){
		game.schedule(3000, {=> game.stop()})
	}
}
