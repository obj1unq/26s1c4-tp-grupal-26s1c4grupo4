import naves.* //importar modulo 
import manager.*
import wollok.game.*
import galaga.*
import hud.*
import nivel.*

object config{
  var property juegoPerdido = false

    method keybinds(){
      if(!juegoPerdido){
        keyboard.right().onPressDo({derecha.mover(naveJugador)})    //moverse derecha
        keyboard.left().onPressDo({izquierda.mover(naveJugador)})  //moverse izquierda
        keyboard.z().onPressDo({naveJugador.disparar()})        //disparar
      }
    }

    
    method keybindReinicio(){
        keyboard.x().onPressDo({ managerJuego.reiniciarJuego() })         //restart
    }

    method keybindInicioNivel1(){
        keyboard.enter().onPressDo({ managerJuego.pasarASiguienteNivel() })
    }
}

object onTicks {
    var enemigosQuedisparen = null
    var enemigosConMovimiento = null
    var velocidadProyectiles = null
    var limpiarProyectilesInvisibles = null

    method tick() {
        self.parar() 

        enemigosQuedisparen = managerEnemigos.onTickDisparo()
        enemigosConMovimiento = managerEnemigos.onTickMovimiento()
        velocidadProyectiles = managerProyectiles.onTickVelocidadProyectiles()
        limpiarProyectilesInvisibles = managerProyectiles.limpiarProyectilesInvisibles()
        
        enemigosQuedisparen.start()
        enemigosConMovimiento.start()
        velocidadProyectiles.start()
        limpiarProyectilesInvisibles.start()
    }

    method parar() {
        if(enemigosQuedisparen != null) enemigosQuedisparen.stop() 
        if(enemigosConMovimiento != null) enemigosConMovimiento.stop()
        if(velocidadProyectiles != null) velocidadProyectiles.stop()
        if(limpiarProyectilesInvisibles != null) limpiarProyectilesInvisibles.stop()
    }
}


class Direccion {
  method mover(pj){
    pj.position(self.siguientePosicion(pj.position()))
  }

  method siguientePosicion(posicion) {
    return game.at(self.siguientePosicionXSiPuede(posicion), self.siguientePosicionY(posicion))
  }

  method siguientePosicionXSiPuede(posicion) {
    if (self.validarSiguientePosicionX(posicion)) {
        return posicion.x() + self.incrementoX()
    } else{
        return posicion.x()
    }  
  }

  method validarSiguientePosicionX(posicion) {
    return self.siguientePosicionX(posicion).between(1, game.width() - 3)
  }

  method siguientePosicionX(posicion) {
    return posicion.x() + self.incrementoX()
  }


  method siguientePosicionY(posicion) {
    return posicion.y() + self.incrementoY()
  }

  method incrementoX() = 0

  method incrementoY() = 0
}

object derecha inherits Direccion {
  override method incrementoX() = 1
}

object izquierda inherits Direccion {
  override method incrementoX() = -1
}

object arriba inherits Direccion {
  override method incrementoY() = 1
}

object abajo inherits Direccion {
  override method incrementoY() = -1
}

