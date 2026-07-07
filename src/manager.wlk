import src.sonido.*
import nivel.*
import config.*
import hud.*
import naves.*

class Manager{
    method mover(){
        self.lista().forEach({elemento => elemento.mover()})
    }

    method limpiar(){
        self.lista().copy().forEach({elemento => self.remover(elemento)})
    }

    method remover(enemigo){
        //primero saco el visual, despues lo elimino de la lista (por las dudas de si pierde la referencia)
        game.removeVisual(enemigo) 
        self.lista().remove(enemigo)
    }

    method agregar(elemento){
        self.lista().add(elemento)
        game.addVisual(elemento)
    }

    method estaVacia() = self.lista().isEmpty()

    method lista()
}

object managerEnemigos inherits Manager{
/*Este objeto se va a encargar de el comportamiento de todo lo relacionado a los enemigos*/
    const property enemigos = []

    override method lista() = enemigos

    method onTickDisparo(){
        const intervaloRandomDeDisparo = 4000.randomUpTo(7000) 
        return game.tick(intervaloRandomDeDisparo,{enemigos.forEach({enemigo => enemigo.disparar()})},true)
    }

    method onTickMovimiento(){
        const intervaloRandomDeMovimiento = 1000.randomUpTo(3000) 
        return game.tick(intervaloRandomDeMovimiento,{enemigos.forEach({enemigo => enemigo.moverse()})},true)
    }
}

object managerProyectiles inherits Manager{
/*Este objeto de lo que se encarga es del comportamiento de todos los proyectiles, o sea de todo lo 
relacionado que va a suceder en pantalla con ellos*/
    const property proyectiles = [] // aca van a estar todos los proyectiles de la pantalla

    override method lista() = proyectiles
}

object managerJuego {
    var nivelActual = nivelInicial

    method iniciarJuego() {
        nivelActual.iniciar()
    }

    method pasarASiguienteNivel(nuevoNivel) {
        game.clear()              // 1. Borra todo lo que está en pantalla (visuales y fondo anterior)
        nivelActual = nuevoNivel  // 2. Actualiza la referencia del nivel
        nivelActual.iniciar()     // 3. Carga el nuevo fondo y los nuevos personajes
    }

    method verificarPasarASiguienteNivel(nuevoNivel){
        if(self.noHayEnemigos()){
            self.pasarASiguienteNivel(nuevoNivel)
        }
    }

    method noHayEnemigos() = managerEnemigos.estaVacia()

    method terminarJuegoPerdido() {
        onTicks.parar()
        musicaInicio.sacarMusica()
        config.keybindReinicio()
        game.addVisual(fondoGameOver)
        game.schedule(3000, { self.reiniciarJuego() })
    }

    method reiniciarJuego() {
        naveJugador.restart()
        musicaInicio.reiniciar()
        self.pasarASiguienteNivel(nivelInicial)
    }
}