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
		items.add(new Escudo(position= game.at(2,17)))
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
	var lobo = new Enemigo(vida = 10, armadura = 0, danio = 15, position = game.at(5,9), image = "lobo.png")
	var loboJefe = new Enemigo(vida = 50, armadura = 10, danio = 40, position = game.at(9,3), image = "lobo.png")
	var property puerta = new Puerta(position = game.at(1,1))

	
	override method nivelNumero(personaje){
		game.say(personaje, "NIVEL 2")
	}
	
	override method agregarEnemigos(){
		enemigos.add(lobo)
		enemigos.add(loboJefe)
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

object fondoDelJuego inherits Visual( image = "fondo.PNG",position = new Position(x=0,y=0) ){	}
object fondoPantallaInicio inherits Visual( image = "PantallaPrincipal.png" , position = new Position(x=0,y=0)){}
//const inicioDelJuego = new Visual( image =  "Presentacion.png", position = game.at(1,1) 

//const winVisual = new Visual( image = "winwin.png", position = game.origin())

//const gameOver = new Visual( image = "sadBob.gif", position = game.at(1,1) )


