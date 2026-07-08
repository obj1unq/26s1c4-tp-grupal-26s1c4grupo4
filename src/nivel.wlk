import manager.*
import sonido.*
import naves.*
import hud.*
import config.*
import proyectil.*
import wollok.game.*

class Nivel{
    method iniciar(){
        game.clear()    
        game.addVisual(self.imagenFondo())
    }

    method imagenFondo() = fondo

    method siguienteNivel() = nivelInicial
}

object nivelInicial inherits Nivel{
    override method iniciar() {
        super() 
        musicaInicio.iniciar()
        config.keybindInicioNivel1()
    }

    override method siguienteNivel() = nivel1

    override method imagenFondo() = fondoInicial
}

object nivelFinal inherits Nivel{   //Para activar esta imagen se debe superar los tres niveles
    override method iniciar() {  
        super()
        naveJugador.vidas(3)
        musicaInicio.sacarMusica()
        game.schedule(7000, { managerJuego.pasarASiguienteNivel() } )
    }

    override method imagenFondo() = fondoFinal
}

class NivelJuego inherits Nivel{
    override method iniciar(){
        super() 
        onTicks.tick()
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

    method enemigosParaEsteNivel()
}

object nivel1 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel1 con patrones de enemigos iniciales
        patronHorizontal1.spawnearEnemigosIniciales()
        patronHorizontal2.spawnearEnemigosIniciales()
    }

    override method siguienteNivel() = nivel2
}

object nivel2 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel2 con una mezca de patrones con enemigos iniciales y avazandos
        patronHorizontal2.spawnearEnemigosIniciales()
        patronHorizontal3.spawnearEnemigosAvanzados()
    }

    override method siguienteNivel() = nivel3
}

object nivel3 inherits NivelJuego{
    override method enemigosParaEsteNivel(){    //Nivel3 solo con patrones de enemigos avanzados, estos tienen 2 vidas
        patronHorizontal2.spawnearEnemigosAvanzados()
        patronHorizontal3.spawnearEnemigosAvanzados()
    }

    override method siguienteNivel() = nivelFinal
}


