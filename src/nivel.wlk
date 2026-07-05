import src.manager.*
import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*

class Nivel {
    method imagenFondo() = "fondo.png"

    method iniciar(){
        game.clear()
        fondo.imagen(self.imagenFondo())
        game.addVisual(fondo)
    }
}

object nivelPresentación inherits Nivel {
    override method iniciar() {
        super() 
        keyboard.enter().onPressDo({ self.iniciarNivel1() })
    }

    override method imagenFondo() = "fondoInicio.png"

    method iniciarNivel1(){
        managerJuego.pasarASiguienteNivel(nivel1)
    }
}

class NivelesJuego inherits Nivel {
    override method iniciar(){
        super() 
        self.eventosParaEsteNivel()
        self.enemigosParaEsteNivel()
        self.configuracionParaNivel()
    }

    method configuracionParaNivel(){
        config.keybinds()
        naveJugador.position(naveJugador.positionInitial())
        game.addVisual(naveJugador)
        game.addVisual(contadorVidas)
    }

    method eventosParaEsteNivel(){
        onTicks.tick()
    }

    method enemigosParaEsteNivel(){}
}

object nivel1 inherits NivelesJuego{
    override method enemigosParaEsteNivel(){
        patronHorizontal2.spawnearEnemigos()
    }
}

object nivel2 inherits NivelesJuego{
    override method enemigosParaEsteNivel(){
        patronHorizontal1.spawnearEnemigos()
    }
}


