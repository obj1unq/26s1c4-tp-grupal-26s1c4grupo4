import src.manager.*
import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*

class Nivel inherits Fondo{
    override method image() = "fondo" + self.indicadorImagen() + ".png"

    method iniciar(){
        game.clear()
        self.ponerBackground()
    }

    method indicadorImagen() = ""
}

object nivelPresentación inherits Nivel{
    override method indicadorImagen() = "Inicio"

    override method iniciar() {
        super() 
        keyboard.enter().onPressDo({ self.iniciarNivel1() })
    }

    method iniciarNivel1(){
        managerJuego.pasarASiguienteNivel(nivel1)
    }
}

object nivelFinal inherits Nivel{   //Para activar esta imagen se debe superar los tres niveles
    override method indicadorImagen() = "Final"

    override method iniciar() {  
        super() 
        config.botonReinicio()
    }
}

class NivelJuego inherits Nivel{
    override method iniciar(){
        super() 
        self.eventosParaEsteNivel()
        self.enemigosParaEsteNivel()
        self.configuracionParaNivel()
    }

    method configuracionParaNivel(){
        config.keybinds()
        naveJugador.position(naveJugador.posicionInicial())
        game.addVisual(naveJugador)
        game.addVisual(contadorVidas)
    }

    method eventosParaEsteNivel(){
        onTicks.tick()
    }

    method enemigosParaEsteNivel(){}
}

object nivel1 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel1 con patrones de enemigos iniciales
        patronHorizontalBasico1.spawnearEnemigos()
        patronHorizontalBasico2.spawnearEnemigos()
        patronHorizontalBasico3.spawnearEnemigos()
    }
}

object nivel2 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel2 con una mezca de patrones con enemigos iniciales y avazandos
        patronHorizontalBasico2.spawnearEnemigos()
        patronVerticalAvanzado2.spawnearEnemigos()
        patronHorizontalBasico3.spawnearEnemigos()
    }
}

object nivel3 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel3 solo con patrones de enemigos avanzados, estos tienen 2 vidas
        patronVerticalAvanzado1.spawnearEnemigos()
        patronVerticalAvanzado2.spawnearEnemigos()
        patronVerticalAvanzado3.spawnearEnemigos()
    }
}


