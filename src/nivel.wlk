import sonido.*
import naves.*
import hud.*
import config.*
import wollok.game.*

object fondo {
    var property imagen = "fondo.png"
    // El fondo siempre debe posicionarse en el origen (0,0)
    method position() = game.at(0, 0) 

    method image() = imagen
}


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
        nivel1.iniciar()
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


