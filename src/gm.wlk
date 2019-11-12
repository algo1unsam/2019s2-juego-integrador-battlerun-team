import cosas.*
import wollok.game.*
import personajes.*


class Nivel{
	const marcoGeneral = new Marco(verticeInicial= new Position(x=0,y=0), verticeFinal = new Position(x=20, y=17), image = "invisible.png")
	var property marcos = [marcoGeneral]
	var property enemigos = []
	var property items = []
	var property personajes = enemigos.copy() //A ESTE SE LE AGREGA EL PERSONAJE PRINCIPAL EN .setearTodo()
	
	method siguienteNivel()
	method agregarEnemigos()
	method agregarMarcos()
	method agregarItems()
	method setearEventos(principal)
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
		
		principal.position(game.at(1,1))
		game.addVisual(fondoDelJuego) 
		game.addVisual(principal)
			// Movilidad del personaje (necesaria para que el objeto pueda ser "no atravesable")
		keyboard.up().onPressDo({ principal.move(principal.position().up(1)) })
		keyboard.down().onPressDo({ principal.move(principal.position().down(1)) })
		keyboard.left().onPressDo({ principal.move(principal.position().left(1)) })
		keyboard.right().onPressDo({ principal.move(principal.position().right(1)) })
		
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
	

	
		
	//METODO QUE SE LLAMA EN EL .wpgm PARA QUE SE CONFIGURE TODO
	method setearTodo(principal){
		personajes.add(principal)
		self.setearPrincipal(principal)
		self.setearBarra()
		self.agregarEnemigos()
		self.agregarMarcos()
		self.agregarItems()
		self.setearEventos(principal)
		self.dibujarTodo()
		self.nivelNumero(principal)
	}
	
	method terminarJuego(){
		game.addVisual(fondoJuegoPerdido)
		game.schedule(3000, {=> game.stop()})
	}
}


/****************************************************************************************************************************************/
object nivel0 inherits Nivel{
	var property pasarDeNivel = false
	
	
	override method setearPrincipal(principal){
		game.addVisual(principal)
		game.addVisual(fondoPantallaInicio)
		keyboard.enter().onPressDo{self.pasarDeNivel(true)}
	}
	
	override method nivelNumero(principal){	
	}
	
	override method agregarEnemigos(){
	}
	
	override method agregarMarcos(){
		marcos.remove(marcoGeneral)
	}
	
	override method agregarItems(){
	}
	
	
	override method setearEventos(principal){ 
	}
	
	override method superado() = pasarDeNivel
	
	override method siguienteNivel() = nivel1
}


/****************************************************************************************************************************************/

object nivel1 inherits Nivel{
	var insecto = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(3,10), image = "insecto.png")
	var insecto2 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(10,7), image = "insecto.png")
	var rata = new Enemigo(vida = 15, armadura = 0, danio = 15, position = game.at(6,5), image = "rata.png")
	var zombie = new Enemigo(vida = 150, armadura = 10, danio = 20, position = game.at(15,7), image = "zombie.png")
	var property puerta = new Puerta( position = game.at(19,16))
	
	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 1")
		personaje.coraHud().dibujoCorazones(personaje)
		personaje.inventarioHud().dibujoVarios(personaje)
	}
	
	override method agregarEnemigos(){
		enemigos.add(insecto)
		enemigos.add(zombie)
		enemigos.add(insecto2)
		enemigos.add(rata)
	}
	
	override method agregarMarcos(){
		
		game.addVisualIn(new Pared1(), game.at(4, 1))
		game.addVisualIn(new Pared1(), game.at(4, 2))
		game.addVisualIn(new Pared1(), game.at(4, 3))
		game.addVisualIn(new Pared1(), game.at(4, 4))
		game.addVisualIn(new Pared1(), game.at(4, 5))
		game.addVisualIn(new Pared1(), game.at(4, 6))
		game.addVisualIn(new Pared1(), game.at(4, 7))
		game.addVisualIn(new Pared1(), game.at(4, 8))
		game.addVisualIn(new Pared1(), game.at(4, 9))
		game.addVisualIn(new Pared1(), game.at(4, 10))
		game.addVisualIn(new Pared1(), game.at(4, 11))
		game.addVisualIn(new Pared1(), game.at(4, 12))
		game.addVisualIn(new Pared1(), game.at(3, 9))
		game.addVisualIn(new Pared1(), game.at(2, 9))
		game.addVisualIn(new Pared1(), game.at(9, 4))
		game.addVisualIn(new Pared1(), game.at(9, 5))
		game.addVisualIn(new Pared1(), game.at(9, 6))
		game.addVisualIn(new Pared1(), game.at(9, 7))
		game.addVisualIn(new Pared1(), game.at(9, 8))
		game.addVisualIn(new Pared1(), game.at(9, 9))
		game.addVisualIn(new Pared1(), game.at(9, 10))
		game.addVisualIn(new Pared1(), game.at(9, 11))
		game.addVisualIn(new Pared1(), game.at(9, 12))
		game.addVisualIn(new Pared1(), game.at(9, 13))
		game.addVisualIn(new Pared1(), game.at(9, 14))
		game.addVisualIn(new Pared1(), game.at(9, 15))
		game.addVisualIn(new Pared1(), game.at(9, 16))
		game.addVisualIn(new Pared1(), game.at(10, 6))
		game.addVisualIn(new Pared1(), game.at(12, 1))
		game.addVisualIn(new Pared1(), game.at(12, 2))
		game.addVisualIn(new Pared1(), game.at(12, 3))
		game.addVisualIn(new Pared1(), game.at(12, 4))
		game.addVisualIn(new Pared1(), game.at(12, 5))
		game.addVisualIn(new Pared1(), game.at(12, 6))
		game.addVisualIn(new Pared1(), game.at(12, 7))
		game.addVisualIn(new Pared1(), game.at(12, 8))
		game.addVisualIn(new Pared1(), game.at(12, 9))
		game.addVisualIn(new Pared1(), game.at(14, 3))
		game.addVisualIn(new Pared1(), game.at(15, 3))
		game.addVisualIn(new Pared1(), game.at(16, 3))
		game.addVisualIn(new Pared1(), game.at(17, 3))
		game.addVisualIn(new Pared1(), game.at(18, 3))
		game.addVisualIn(new Pared1(), game.at(19, 3))
		game.addVisualIn(new Pared1(), game.at(15, 16))
		game.addVisualIn(new Pared1(), game.at(15, 15))
		game.addVisualIn(new Pared1(), game.at(15, 14))
		game.addVisualIn(new Pared1(), game.at(15, 16))
		game.addVisualIn(new Pared1(), game.at(15, 14))
		game.addVisualIn(new Pared1(), game.at(16, 14))
		game.addVisualIn(new Pared1(), game.at(17, 14))
		
		
	}
	
	
	override method agregarItems(){
		items.add(new Pocion(position= game.at(13,15)))
		items.add(new Daga(position= game.at(3,8)))
		items.add(new Escudo(position= game.at(17,2)))
		items.add(puerta)
	}
	
	
	override method setearEventos(principal){
	game.onTick(1300, zombie.identity().toString() + "Persigue", {=> zombie.perseguiA(principal)})
	game.onTick(400, rata.identity().toString() + "Persigue", {=> rata.perseguiA(principal)})
	game.onTick(800, insecto2.identity().toString() + "Persigue", {=> insecto2.perseguiA(principal)})
	game.onTick(800, insecto.identity().toString() + "Persigue", {=> insecto.perseguiA(principal)})
	
	game.onTick(700, zombie.identity().toString() + "Golpea", {=> if(game.colliders(zombie).size() > 0) game.colliders(zombie).first().teChoco(zombie)})
	game.onTick(300, rata.identity().toString() + "Golpea", {=> if(game.colliders(rata).size() > 0) game.colliders(rata).first().teChoco(rata)})
	game.onTick(500, insecto2.identity().toString() + "Golpea", {=> if(game.colliders(insecto2).size() > 0) game.colliders(insecto2).first().teChoco(insecto2)})
	game.onTick(500, insecto.identity().toString() +"Golpea", {=> if(game.colliders(insecto).size() > 0) game.colliders(insecto).first().teChoco(insecto)}) 
	}
	
	override method superado() = self.puerta().estoyAbierta()
	
	override method siguienteNivel() = nivel2
}


/****************************************************************************************************************************************/

object nivel2 inherits Nivel{
	var vampiro = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(4,10), image = "vampiro.png")
	var vampiro2 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(13,1), image = "vampiro.png")
	var lobo = new Enemigo(vida = 15, armadura = 0, danio = 15, position = game.at(10,4), image = "lobo.png")
	var lobo2 = new Enemigo(vida = 150, armadura = 10, danio = 20, position = game.at(3,15), image = "lobo.png")
	var orco = new Enemigo(vida = 150, armadura = 10, danio = 20, position = game.at(19,9), image = "orco_jefe.png")
	var property puerta = new Puerta( position = game.at(19,6))
	

	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 2")
		personaje.coraHud().dibujoCorazones(personaje)
		personaje.armorHud().dibujoArmadura(personaje)
		personaje.espadaHud().dibujoEspada(personaje)
		personaje.inventarioHud().dibujoVarios(personaje)
	}
	
	override method agregarEnemigos(){
		enemigos.add(vampiro)
		enemigos.add(vampiro2)
		enemigos.add(lobo)
		enemigos.add(lobo2)
		enemigos.add(orco)
	}
	
	override method agregarMarcos(){
		
		game.addVisualIn(new ParedLava(), game.at(3, 3))
		game.addVisualIn(new ParedLava(), game.at(5, 3))
		game.addVisualIn(new ParedLava(), game.at(7, 3))
		game.addVisualIn(new ParedLava(), game.at(9, 3))
		game.addVisualIn(new ParedLava(), game.at(11, 3))
		game.addVisualIn(new ParedLava(), game.at(13, 3))
		game.addVisualIn(new ParedLava(), game.at(15, 3))
		game.addVisualIn(new ParedLava(), game.at(17, 3))
		game.addVisualIn(new ParedLava(), game.at(3, 5))
		game.addVisualIn(new ParedLava(), game.at(5, 5))
		game.addVisualIn(new ParedLava(), game.at(7, 5))
		game.addVisualIn(new ParedLava(), game.at(9, 5))
		game.addVisualIn(new ParedLava(), game.at(11, 5))
		game.addVisualIn(new ParedLava(), game.at(13, 5))
		game.addVisualIn(new ParedLava(), game.at(15, 5))
		game.addVisualIn(new ParedLava(), game.at(3, 7))
		game.addVisualIn(new ParedLava(), game.at(5, 7))
		game.addVisualIn(new ParedLava(), game.at(3, 9))
		game.addVisualIn(new ParedLava(), game.at(5, 9))
		game.addVisualIn(new ParedLava(), game.at(7, 9))
		game.addVisualIn(new ParedLava(), game.at(9, 9))
		game.addVisualIn(new ParedLava(), game.at(11, 9))
		game.addVisualIn(new ParedLava(), game.at(13, 9))
		game.addVisualIn(new ParedLava(), game.at(15, 9))
		game.addVisualIn(new Pared2(), game.at(1, 14))
		game.addVisualIn(new Pared2(), game.at(2, 14))
		game.addVisualIn(new Pared2(), game.at(3, 14))
		game.addVisualIn(new Pared2(), game.at(4, 14))
		game.addVisualIn(new Pared2(), game.at(5, 14))
		game.addVisualIn(new Pared2(), game.at(6, 14))
		game.addVisualIn(new Pared2(), game.at(7, 14))
		game.addVisualIn(new Pared2(), game.at(8, 14))
		game.addVisualIn(new Pared2(), game.at(9, 14))
		game.addVisualIn(new Pared2(), game.at(10, 14))
		game.addVisualIn(new Pared2(), game.at(10, 13))
		game.addVisualIn(new Pared2(), game.at(10, 12))
		game.addVisualIn(new Pared2(), game.at(10, 11))
		game.addVisualIn(new Pared2(), game.at(16, 7))
		game.addVisualIn(new Pared2(), game.at(15, 7))
		game.addVisualIn(new Pared2(), game.at(14, 7))
		game.addVisualIn(new Pared2(), game.at(13, 7))
		game.addVisualIn(new Pared2(), game.at(12, 7))
		game.addVisualIn(new Pared2(), game.at(11, 7))
		game.addVisualIn(new Pared2(), game.at(10, 7))
		game.addVisualIn(new Pared2(), game.at(9, 7))
		game.addVisualIn(new Pared2(), game.at(8, 7))
		game.addVisualIn(new Pared2(), game.at(7, 7))
		game.addVisualIn(new Pared2(), game.at(19, 5))
		game.addVisualIn(new Pared2(), game.at(18, 5))
		game.addVisualIn(new Pared2(), game.at(17, 5))
		game.addVisualIn(new Pared2(), game.at(17, 6))
		game.addVisualIn(new Pared2(), game.at(17, 7))
		game.addVisualIn(new Pared2(), game.at(17, 8))
		game.addVisualIn(new Pared2(), game.at(17, 9))
		game.addVisualIn(new Pared2(), game.at(17, 10))
		game.addVisualIn(new Pared2(), game.at(17, 11))
		game.addVisualIn(new Pared2(), game.at(17, 12))
		game.addVisualIn(new Pared2(), game.at(18, 9))
		
	}
	
	override method agregarItems(){
		items.add(new Casco(position= game.at(9,13)))
		items.add(new Espada(position= game.at(19,4)))
		items.add(new Botas(position= game.at(10,6)))
		items.add(new Escudo(position= game.at(2,16)))
		items.add(puerta)
	}
	
		override method setearEventos(principal){
	game.onTick(1300, orco.identity().toString() + "Persigue", {=> orco.perseguiA(principal)})
	game.onTick(400, lobo2.identity().toString() + "Persigue", {=> lobo2.perseguiA(principal)})
	game.onTick(800, vampiro2.identity().toString() + "Persigue", {=> vampiro2.perseguiA(principal)})
	game.onTick(800, vampiro.identity().toString() + "Persigue", {=> vampiro.perseguiA(principal)})
	game.onTick(400, lobo.identity().toString() + "Persigue", {=> lobo.perseguiA(principal)})
	
	game.onTick(700, orco.identity().toString() + "Golpea", {=> if(game.colliders(orco).size() > 0) game.colliders(orco).first().teChoco(orco)})
	game.onTick(300, lobo2.identity().toString() + "Golpea", {=> if(game.colliders(lobo2).size() > 0) game.colliders(lobo2).first().teChoco(lobo2)})
	game.onTick(500, vampiro2.identity().toString() + "Golpea", {=> if(game.colliders(vampiro2).size() > 0) game.colliders(vampiro2).first().teChoco(vampiro2)})
	game.onTick(500, vampiro.identity().toString() +"Golpea", {=> if(game.colliders(vampiro).size() > 0) game.colliders(vampiro).first().teChoco(vampiro)}) 
	game.onTick(300, lobo.identity().toString() + "Golpea", {=> if(game.colliders(lobo).size() > 0) game.colliders(lobo).first().teChoco(lobo)} )
	}
	
	override method superado() = self.puerta().estoyAbierta()

	override method siguienteNivel() = nivel3
	
}


/****************************************************************************************************************************************/


object nivel3 inherits Nivel{
	
	var vampiro = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(7,14), image = "vampiro.png")
	var vampiro2 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(8,13), image = "vampiro.png")
	var vampiro3 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(9,12), image = "vampiro.png")
	var vampiro4 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(10,11), image = "vampiro.png")
	var orco = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(14,16), image = "orco_jefe.png")
	var orco2 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(1,13), image = "orco_jefe.png")
	var zombie = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(5,6), image = "zombie.png")
	var zombie2 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(8,4), image = "zombie.png")
	var zombie3 = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(9,1), image = "zombie.png")
	var dragon = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(17,13), image = "dragon.png")
	

	var property puerta = new Puerta( image="princesa.png", position = game.at(19,1))
	
	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 3, FINAL!!!!")
		personaje.coraHud().dibujoCorazones(personaje)
		personaje.armorHud().dibujoArmadura(personaje)
		personaje.espadaHud().dibujoEspada(personaje)
		personaje.inventarioHud().dibujoVarios(personaje)
	}
	
	override method agregarEnemigos(){
		enemigos.add(vampiro)
		enemigos.add(vampiro2)
		enemigos.add(vampiro3)
		enemigos.add(vampiro4)
		enemigos.add(orco)
		enemigos.add(orco2)
		enemigos.add(zombie)
		enemigos.add(zombie2)
		enemigos.add(zombie3)
		enemigos.add(dragon)
		
	}
	
	override method agregarMarcos(){
		
		game.addVisualIn(new ParedLava(), game.at(2,2))
		game.addVisualIn(new ParedLava(), game.at(4,2))
		game.addVisualIn(new ParedLava(), game.at(6,2))
		game.addVisualIn(new ParedLava(), game.at(8,2))
		game.addVisualIn(new ParedLava(), game.at(10,2))
		game.addVisualIn(new ParedLava(), game.at(12,2))
		game.addVisualIn(new ParedLava(), game.at(14,2))
		game.addVisualIn(new ParedLava(), game.at(3,3))
		game.addVisualIn(new ParedLava(), game.at(5,3))
		game.addVisualIn(new ParedLava(), game.at(7,3))
		game.addVisualIn(new ParedLava(), game.at(9,3))
		game.addVisualIn(new ParedLava(), game.at(11,3))
		game.addVisualIn(new ParedLava(), game.at(13,3))
		game.addVisualIn(new ParedLava(), game.at(15,3))
		game.addVisualIn(new ParedLava(), game.at(3,5))
		game.addVisualIn(new ParedLava(), game.at(5,5))
		game.addVisualIn(new ParedLava(), game.at(7,5))
		game.addVisualIn(new ParedLava(), game.at(9,5))
		game.addVisualIn(new ParedLava(), game.at(11,5))
		game.addVisualIn(new ParedLava(), game.at(13,5))
		game.addVisualIn(new ParedLava(), game.at(15,5))
		game.addVisualIn(new ParedLava(), game.at(15,6))
		game.addVisualIn(new ParedLava(), game.at(13,6))
		game.addVisualIn(new ParedLava(), game.at(11,6))
		game.addVisualIn(new ParedLava(), game.at(4,7))
		game.addVisualIn(new ParedLava(), game.at(6,7))
		game.addVisualIn(new ParedLava(), game.at(8,7))
		game.addVisualIn(new Pared3(), game.at(2,6))
		game.addVisualIn(new Pared3(), game.at(2,7))
		game.addVisualIn(new Pared3(), game.at(2,8))
		game.addVisualIn(new Pared3(), game.at(2,9))
		game.addVisualIn(new Pared3(), game.at(2,10))
		game.addVisualIn(new Pared3(), game.at(2,11))
		game.addVisualIn(new Pared3(), game.at(2,12))
		game.addVisualIn(new Pared3(), game.at(2,13))
		game.addVisualIn(new Pared3(), game.at(2,14))
		game.addVisualIn(new Pared3(), game.at(2,15))
		game.addVisualIn(new Pared3(), game.at(2,16))
		game.addVisualIn(new Pared3(), game.at(3,13))
		game.addVisualIn(new Pared3(), game.at(4,13))
		game.addVisualIn(new Pared3(), game.at(5,13))
		game.addVisualIn(new Pared3(), game.at(3,15))
		game.addVisualIn(new Pared3(), game.at(4,15))
		game.addVisualIn(new Pared3(), game.at(5,15))
		game.addVisualIn(new Pared3(), game.at(6,15))
		game.addVisualIn(new Pared3(), game.at(7,15))
		game.addVisualIn(new Pared3(), game.at(8,15))
		game.addVisualIn(new Pared3(), game.at(9,15))
		game.addVisualIn(new Pared3(), game.at(10,15))
		game.addVisualIn(new Pared3(), game.at(11,15))
		game.addVisualIn(new Pared3(), game.at(12,15))
		game.addVisualIn(new Pared3(), game.at(16,1))
		game.addVisualIn(new Pared3(), game.at(16,2))
		game.addVisualIn(new Pared3(), game.at(16,3))
		game.addVisualIn(new Pared3(), game.at(16,4))
		game.addVisualIn(new Pared3(), game.at(16,5))
		game.addVisualIn(new Pared3(), game.at(16,6))
		game.addVisualIn(new Pared3(), game.at(16,7))
		game.addVisualIn(new Pared3(), game.at(16,8))
		game.addVisualIn(new Pared3(), game.at(16,9))
		game.addVisualIn(new Pared3(), game.at(16,10))
		game.addVisualIn(new Pared3(), game.at(16,11))
		game.addVisualIn(new Pared3(), game.at(16,12))
		game.addVisualIn(new Pared3(), game.at(16,13))
		game.addVisualIn(new Pared3(), game.at(16,14))
		game.addVisualIn(new Pared3(), game.at(12,14))
		game.addVisualIn(new Pared3(), game.at(12,13))
		game.addVisualIn(new Pared3(), game.at(12,12))
		game.addVisualIn(new Pared3(), game.at(12,11))
		game.addVisualIn(new Pared3(), game.at(12,10))
		game.addVisualIn(new Pared3(), game.at(12,9))
		game.addVisualIn(new Pared3(), game.at(12,8))
		game.addVisualIn(new ParedCoins(), game.at(17,14))
		game.addVisualIn(new ParedCoins(), game.at(17,10))
		game.addVisualIn(new ParedCoins(), game.at(18,10))
		game.addVisualIn(new ParedCoins(), game.at(18,12))
		game.addVisualIn(new ParedCoins(), game.at(19,12))
		game.addVisualIn(new ParedCoins(), game.at(18,8))
		game.addVisualIn(new ParedCoins(), game.at(19,8))
		game.addVisualIn(new ParedCoins(), game.at(17,6))
		game.addVisualIn(new ParedCoins(), game.at(18,6))
		game.addVisualIn(new ParedCoins(), game.at(18,4))
		game.addVisualIn(new ParedCoins(), game.at(19,4))
		game.addVisualIn(new ParedCoins(), game.at(17,2))
		game.addVisualIn(new ParedCoins(), game.at(17,1))
		
	}
	
	
	override method agregarItems(){
		items.add(new Sable(position= game.at(1,16)))
		items.add(new Armadura(position= game.at(3,16)))
		items.add(new Pocion(position= game.at(3,14)))
		items.add(puerta)
	}
	
	
	override method setearEventos(principal){
	game.onTick(600, vampiro.identity().toString() + "Persigue", {=> vampiro.perseguiA(principal)})
	game.onTick(600, vampiro2.identity().toString() + "Persigue", {=> vampiro2.perseguiA(principal)})
	game.onTick(600, vampiro3.identity().toString() + "Persigue", {=> vampiro3.perseguiA(principal)})
	game.onTick(600, vampiro4.identity().toString() + "Persigue", {=> vampiro4.perseguiA(principal)})
	game.onTick(1000, orco.identity().toString() + "Persigue", {=> orco.perseguiA(principal)})
	game.onTick(1000, orco2.identity().toString() + "Persigue", {=> orco2.perseguiA(principal)})
	game.onTick(1300, zombie.identity().toString() + "Persigue", {=> zombie.perseguiA(principal)})
	game.onTick(1300, zombie2.identity().toString() + "Persigue", {=> zombie2.perseguiA(principal)})
	game.onTick(1300, zombie3.identity().toString() + "Persigue", {=> zombie3.perseguiA(principal)})
	game.onTick(200, dragon.identity().toString() + "Persigue", {=> dragon.perseguiA(principal)})
	
	game.onTick(700, vampiro.identity().toString() + "Golpea", {=> if(game.colliders(vampiro).size() > 0) game.colliders(vampiro).first().teChoco(vampiro)})
	game.onTick(700, vampiro2.identity().toString() + "Golpea", {=> if(game.colliders(vampiro2).size() > 0) game.colliders(vampiro2).first().teChoco(vampiro2)})
	game.onTick(700, vampiro3.identity().toString() + "Golpea", {=> if(game.colliders(vampiro3).size() > 0) game.colliders(vampiro3).first().teChoco(vampiro3)})
	game.onTick(700, vampiro4.identity().toString() + "Golpea", {=> if(game.colliders(vampiro4).size() > 0) game.colliders(vampiro4).first().teChoco(vampiro4)})
	game.onTick(700, orco.identity().toString() + "Golpea", {=> if(game.colliders(orco).size() > 0) game.colliders(orco).first().teChoco(orco)})
	game.onTick(700, zombie.identity().toString() + "Golpea", {=> if(game.colliders(zombie).size() > 0) game.colliders(zombie).first().teChoco(zombie)})
	game.onTick(700, zombie2.identity().toString() + "Golpea", {=> if(game.colliders(zombie2).size() > 0) game.colliders(zombie2).first().teChoco(zombie2)})
	game.onTick(700, zombie3.identity().toString() + "Golpea", {=> if(game.colliders(zombie3).size() > 0) game.colliders(zombie3).first().teChoco(zombie3)})
	game.onTick(700, dragon.identity().toString() + "Golpea", {=> if(game.colliders(dragon).size() > 0) game.colliders(dragon).first().teChoco(dragon)})
	
	
	}
	
	override method superado() = self.puerta().estoyAbierta()
	
	override method siguienteNivel() = ganar
}

/****************************************************************************************************************************************/
object ganar{
	
	method esFinal() = true 
	
	method terminarJuego(){
		game.addVisual(fondoJuegoGanado)
		game.schedule(3000, {=> game.stop()})
	}
}

/************************************TANTEADOR************************************************/

object score{
	const posicionInicial = new Position(x=22,y=5)
	
	method dibujarItem(elemento,posicion){
		game.addVisual(new Visual(image = elemento.image(),position = posicion))
		game.addVisualIn(numberConverter.getNumberImage(elemento.score().div(10)),posicion.right(1))
		game.addVisualIn(numberConverter.getNumberImage(elemento.score() % 10),posicion.right(2))
		
	}

}

object numberConverter{
    method getNumberImage(number){
    	return new Visual(image= "nro" + number + ".png")
    }
}

/****************************************************************************************************************************************/

class Visual {
	var property image
	var property position = game.origin()
}
class Paredes inherits Visual{
	var property esAtravesable = false	
}
class Pared1 inherits Paredes{	override method image() = "pared_1.png"}
class Pared2 inherits Paredes{	override method image() = "pared_2.png"}
class Pared3 inherits Paredes{ override method image() = "pared_3.png"}
class ParedCoins inherits Paredes{ override method image() = "pared_coins.png"}
class ParedLava inherits Paredes{ override method image() = "pared_lava.png"}

object fondoDelJuego inherits Visual( image = "fondo.PNG",position = game.origin() ){}
object fondoPantallaInicio inherits Visual( image = "PantallaPrincipal.png" , position = game.origin()){}
object fondoJuegoGanado inherits Visual(image = "youWin.png", position = game.origin()){}
object fondoJuegoPerdido inherits Visual(image = "youLose.png", position = game.origin()){}


//const inicioDelJuego = new Visual( image =  "Presentacion.png", position = game.at(1,1) 

//const winVisual = new Visual( image = "winwin.png", position = game.origin())

//const gameOver = new Visual( image = "sadBob.gif", position = game.at(1,1) )


