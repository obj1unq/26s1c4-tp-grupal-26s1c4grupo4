import naves.* //importar modulo 
import manager.*
import wollok.game.*
import galaga.*
import hud.*
import nivel.*

object config{
    method keybinds(){
        keyboard.right().onPressDo({derecha.mover(naveJugador)})    //moverse derecha
        keyboard.left().onPressDo({izquierda.mover(naveJugador)})  //moverse izquierda
        keyboard.z().onPressDo({naveJugador.disparar()})        //disparar
        keyboard.t().onPressDo({ managerJuego.pasarASiguienteNivel(nivel2)}) //testear nivel 2
    }
    
    method botonReinicio(){
        keyboard.x().onPressDo({ gestorJuego.reiniciarJuego() })         //restart
    }
}

object onTicks {
    var tickP = null
    var spawnEnemigos = null
    var disparar = null
    var moverse = null

    method tick() {
        self.parar() 
        
        // Agregar numeros random para el intervalo de disparo de los enemigos y de spawn de enemigos
        const intervaloRandomDeSpawn = 3000.randomUpTo(6000)
        const intervaloRandomDeDisparo = 200.randomUpTo(1000)
        const intervaloRandomDeMovimiento = 1000.randomUpTo(3000)

        tickP = game.tick(intervaloRandomDeDisparo, {managerProyectiles.mover()}, true)
        spawnEnemigos = game.tick(intervaloRandomDeSpawn, {enemigoIndividual.spawnearEnemigos()}, true)
        disparar = managerEnemigos.onTickDisparo()
        moverse = managerEnemigos.onTickMovimiento()
        
        tickP.start()
        spawnEnemigos.start()
        disparar.start()
        moverse.start()
    }

    method parar() {
        if (tickP != null) tickP.stop()
        if (spawnEnemigos != null) spawnEnemigos.stop()
        // Si disparar es un objeto tick, también deberías detenerlo
        if (disparar != null) disparar.stop() 
        if(moverse != null) moverse.stop()
    }
}

object gestorJuego {
    method terminarJuego() {
        onTicks.parar()
        config.botonReinicio()
        game.addVisual(pantallaGameOver)
        game.schedule(3000, { self.reiniciarJuego() })

    }

    method reiniciarJuego() {
        naveJugador.restart()
        managerJuego.pasarASiguienteNivel(nivelPresentación)
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

object tablero {
    method dentro(position) {
        return position.x().between(0, game.width() -1) and position.y().between(0, game.height() -1) 
    }
}
