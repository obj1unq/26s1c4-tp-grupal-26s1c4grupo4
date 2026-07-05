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

    method tick() {
        // Detener ticks anteriores si existen para evitar conflictos
        self.parar() 
        
        // Agregar numeros random para el intervalo de disparo de los enemigos y de spawn de enemigos
        const intervaloRandomDeSpawn = 3000.randomUpTo(6000)
        const intervaloRandomDeDisparo = 200.randomUpTo(1000)

        tickP = game.tick(intervaloRandomDeDisparo, {managerProyectiles.mover()}, true)
        spawnEnemigos = game.tick(intervaloRandomDeSpawn, {enemigoIndividual.spawnearEnemigos()}, true)
        disparar = managerEnemigos.onTickDisparo()
        
        tickP.start()
        spawnEnemigos.start()
        disparar.start()
    }

    method parar() {
        if (tickP != null) tickP.stop()
        if (spawnEnemigos != null) spawnEnemigos.stop()
        // Si disparar es un objeto tick, también deberías detenerlo
        // if (disparar != null) disparar.stop() 
    }
}

object gestorJuego {
    method terminarJuego() {
        // 1. Limpiamos todo
        game.clear() 
        config.botonReinicio()
        // 2. Ponemos el fondo negro usando boardGround (así no rompe con strings)
        game.addVisual(pantallaGameOver)
        
        // 3. Agregamos los visuales (estos objetos deben existir en hud.wlk)
        //fondo.imagen(pantallaGameOver.image())
        game.schedule(3000, { self.reiniciarJuego() })
        
        // 4. Esperamos 3 segundos antes de permitir reiniciar si quisieras, 
        // pero como ahora usamos la tecla R, dejamos que el usuario decida.
    }

    method reiniciarJuego() {
        // 1. Limpiamos la pantalla de Game Over
        //game.clear()
        naveJugador.restart()
        managerJuego.pasarASiguienteNivel(nivelPresentación)
        // 2. Reiniciamos lógica de jugador
        //naveJugador.restart()
        
        // 3. Re-dibujamos el escenario inicial
       /* 
        game.addVisual(naveJugador)
        game.addVisual(contadorVidas)
        config.keybinds()        
        // 4. Reactivamos los Ticks (esto es clave para que los enemigos vuelvan)
        onTicks.tick()*/
    }

}

class Direccion {
  method mover(pj){
    pj.position(self.siguientePosicion(pj.position()))
  }

  method siguientePosicion(posicion) {
    return game.at(posicion.x() + self.incrementoX(), posicion.y() + self.incrementoY())
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
