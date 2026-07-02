import jugador.* //importar modulo 
import direccion.*
import managers.*
import enemigos.*
import gameover.*
import wollok.game.*
object config{
    method keybinds(){
        keyboard.d().onPressDo({derecha.mover(jugador)})    //moverse derecha
        keyboard.a().onPressDo({izquierda.mover(jugador)})  //moverse izquierda
        keyboard.f().onPressDo({jugador.disparar()})        //disparar
        keyboard.r().onPressDo({ gestorJuego.reiniciarJuego() })         //restart
    }
}

object onTicks {
    var tickP = null
    var spawnEnemigos = null
    var disparar = null

    method tick() {
        // Detener ticks anteriores si existen para evitar conflictos
        self.parar() 
        
        tickP = game.tick(250, {managerProyectiles.mover()}, true)
        spawnEnemigos = game.tick(5000, {enemigoIndividual.spawnearEnemigos()}, true)
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
