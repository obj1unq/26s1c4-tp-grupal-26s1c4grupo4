import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*




object nivelInicio{
    method iniciar(){
        game.clear()
        game.cellSize(32)
        game.height(16)
        game.width(16)
        game.title("Galaga")
        game.ground("background-inicio.png")
        keyboard.enter().onPressDo({ self.iniciarNivel1() })
    }

    method iniciarNivel1(){
        nivel1.iniciar()
    }
}
object nivel1 {
    method iniciar(){
        game.clear()
        config.keybinds()
        onTicks.tick()
        patronHorizontal2.spawnearEnemigos()
        game.addVisual(naveJugador)
        game.addVisual(contadorVidas)
    }
}

