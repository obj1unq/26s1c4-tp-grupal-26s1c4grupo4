import src.manager.*
import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*

class Nivel {
    method imagenFondo() = "fondo.png"

    // Este método solo inicializa los elementos visuales de ESTE nivel
    method iniciar(){
        game.clear() // Limpia visuales y fondo del nivel anterior
        fondo.imagen(self.imagenFondo())
        game.addVisual(fondo)
    }
}

object nivelPresentación inherits Nivel {
    // Al heredar de Nivel, su método iniciar() limpia el juego y pone su fondo
    override method iniciar() {
        super() 
        keyboard.enter().onPressDo({ self.iniciarNivel1() })
        musicaInicio.iniciar() // Descomenta cuando lo uses
    }

    override method imagenFondo() = "fondoInicio.png"

    method iniciarNivel1(){
        managerJuego.pasarASiguienteNivel(nivel1)
    }
}

object nivel1 inherits Nivel {
    override method iniciar(){
       super() // Hace game.clear() y cambia al fondo de nivel 1
        
        //Aquí cargas las mecánicas exclusivas de este nivel:
        config.keybinds()
        onTicks.tick()
        patronHorizontal2.spawnearEnemigos()
        game.addVisual(naveJugador)
        game.addVisual(contadorVidas)
    }
}


