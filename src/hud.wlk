import cosas.*
import personajes.*
import gm.*
import wollok.game.*



object corazon{
	var posX = 21
	const posY = 6
	var property conteoDeCorazones = 0
	method cantidadDeCorazones(principal){
		return (principal.vida().div(250)) +1
	}
	
	method dibujoCorazones(principal){  // se usa al agarrar
			posX=21
		(0..self.cantidadDeCorazones(principal)-1).forEach{
			iteracion => var cora = new Pocion(position = game.at(posX,posY))
			game.addVisual(cora)
			posX=posX+1
		}
	}
	
	method agregoCorazon(principal){  // se usa al agarrar
		var cora = new Pocion(position=game.at(posX,posY))
		game.addVisual(cora)
		posX=posX+1
	}
	
	method remuevoCorazon(principal){ // se usa al pasar de nivel para dibujar todo de 0
		posX=posX-1
		game.removeVisual(game.getObjectsIn(game.at(posX,posY)).get(0))
	}
}




object armor{
	var estadistica = [30,60]
	var posX = 24
	var posY = 8 
	var index = 0
	
	method agregoArmadura(principal){  // se usa al agarrar
		if(principal.armadura() > estadistica.get(index)  && index < 2){
		var armadura = new Armadura(position=game.at(posX,posY))
		game.addVisual(armadura)
		posX = posX+1
		index = index+1
		}
		
	}
	
	method dibujoArmadura(principal){ // se usa al pasar de nivel para dibujar todo de 0
			posX=24
		(0..index).forEach{
			iteracion =>if (iteracion>0){
			var armor = new Armadura(position = game.at(posX,posY))
			game.addVisual(armor)
			posX=posX+1
			
			}
		}
	}
}

object espada{
	
	var estadistica = [20,60]
	var posX = 24
	var posY = 9 
	var index = 0
	
	method agregoEspada(principal){  // se usa al agarrar 
		if(principal.danio() > estadistica.get(index)){
		var espada = new Espada(position=game.at(posX,posY))
		game.addVisual(espada)
		posX = posX+1
		index = index+1
		}
		
	}
	
	method dibujoEspada(principal){ // se usa al pasar de nivel para dibujar todo de 0
			posX=24
		(0..index).forEach{
			iteracion =>if (iteracion>0){
			var espada = new Espada(position = game.at(posX,posY))
			game.addVisual(espada)
			posX=posX+1
			
			}
		}
	}
}

object _inventario{
	method agregoInventario(principal){ // se usa al agarrar 
		game.addVisual(principal.inventario().last()) 
	}
	
	method dibujoVarios(principal){
		(0..principal.inventario().size()-1).forEach{
			iteracion => if(principal.inventario().size()>0){
				game.addVisual(principal.inventario().get(iteracion))
			}
			
		}
	}
}
