import nave.*
import enemigo.*
import direccion.*
import proyectil.*
import wollok.game.*

object primerNivel{
  const altoTablero = 15
  const anchoTablero = 15
  const maximoDeEnemigos = 10
  var enemigosSpawneados = 0

    method configurar(){
      //configuracion del nivel
        game.title("Galaga") 	
	      game.height(altoTablero) 		
	      game.width(anchoTablero) 			
	      game.cellSize(225) 		// el cell depende del tama;o del asset no puede ser eso. 
	      game.boardGround("fondo.png")

      //creacion de la nave
        game.addVisual(nave)
        game.schedule(5000, {self.spawnEnemigo()})
    }

    method spawnEnemigo() {
        const enemigo = new EnemigoInventado()
        self.spawnAleatorio(enemigo)
    }

    method spawnAleatorio(enemigo){
        const posicion = new Position(
			    x = 1.randomUpTo(anchoTablero),
			    y = 15)
        if (self.validarPosibilidadDeSpawn(posicion)){
          enemigo.position(posicion)
          game.addVisual(enemigo)
          enemigosSpawneados += 1
        } else {
          self.spawnAleatorio(enemigo)
        }
    }

    method validarPosibilidadDeSpawn(posicion){
        return game.getObjectsIn(posicion).isEmpty() && enemigosSpawneados < maximoDeEnemigos
    }

    method finalizarNivel(){
      if (self.validarFinDeNivel()){
        game.stop()
      }
    }

    method validarFinDeNivel(){
      return enemigosSpawneados >= maximoDeEnemigos
    }
    
}

