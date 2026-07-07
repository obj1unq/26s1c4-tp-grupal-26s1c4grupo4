import src.manager.*
import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*

class Nivel{
    method iniciar(){
        game.clear()    
        game.addVisual(self.imagenFondo())
    }

    method imagenFondo() = fondo
}

object nivelInicial inherits Nivel{
    override method iniciar() {
        super() 
        keyboard.enter().onPressDo({ self.iniciarNivel1() })
        musicaInicio.play()
    }

    method iniciarNivel1(){
        managerJuego.pasarASiguienteNivel(nivel1)
    }

    override method imagenFondo() = fondoInicial
}

object nivelFinal inherits Nivel{   //Para activar esta imagen se debe superar los tres niveles
    override method iniciar() {  
        super() 
        config.botonReinicio()
    }
    override method imagenFondo() = fondoFinal
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
        game.onCollideDo(naveJugador,{colisionado => colisionado.colisionasteJugador(naveJugador)})
    }

    method eventosParaEsteNivel(){
        onTicks.tick()
    }

    method enemigosParaEsteNivel(){}
}

object nivel1 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel1 con patrones de enemigos iniciales
        patronHorizontalBasico2.spawnearEnemigosIniciales()
        patronHorizontalBasico1.spawnearEnemigosAvanzados()
    }
}

object nivel2 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel2 con una mezca de patrones con enemigos iniciales y avazandos
        patronVerticalAvanzado2.spawnearEnemigosAvanzados()
        patronHorizontalBasico3.spawnearEnemigosIniciales()
    }
}

object nivel3 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel3 solo con patrones de enemigos avanzados, estos tienen 2 vidas
        patronVerticalAvanzado2.spawnearEnemigosAvanzados()
        patronVerticalAvanzado3.spawnearEnemigosAvanzados()
    }
}


