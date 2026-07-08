import src.sonido.*
import nivel.*
import config.*
import hud.*
import naves.*

class Manager{
    const elementos = []

    method mover(){
        elementos.forEach({elemento => elemento.mover()})
    }

    method limpiar(){
        elementos.forEach({elemento => self.remover(elemento)})
    }

    method remover(elemento){
        //primero saco el visual, despues lo elimino de la lista (por las dudas de si pierde la referencia)
        game.removeVisual(elemento) 
        elementos.remove(elemento)
    }

    method agregar(elemento){
        elementos.add(elemento)
        game.addVisual(elemento)
    }
}

object managerEnemigos inherits Manager{
/*Este objeto se va a encargar de el comportamiento de todo lo relacionado a los enemigos*/

    method hayEnemigos() = !elementos.isEmpty()

    method onTickDisparo(){
        const intervaloRandomDeDisparo = 4000.randomUpTo(7000) 
        return game.tick(intervaloRandomDeDisparo,{elementos.forEach({enemigo => enemigo.disparar()})},true)
    }

    method onTickMovimiento(){
        const intervaloRandomDeMovimiento = 1000.randomUpTo(3000) 
        return game.tick(intervaloRandomDeMovimiento,{elementos.forEach({enemigo => enemigo.moverse()})},true)
    }

    override method agregar(enemigo){
        super(enemigo)
        game.onCollideDo(enemigo, {colisionado => colisionado.colisionarEnemigo(enemigo)})
    }

    override method remover(enemigo){
        super(enemigo)
        managerJuego.validarPasarASiguienteNivel()
    }
}

object managerProyectiles inherits Manager{
/*Este objeto de lo que se encarga es del comportamiento de todos los proyectiles, o sea de todo lo 
relacionado que va a suceder en pantalla con ellos*/
    // aca van a estar todos los proyectiles de la pantalla
}

object managerJuego {
    var property nivelActual = nivelInicial 

    method iniciarJuego() {
        nivelActual.iniciar()
    }

    //saber que eso existe, sacar solo lo que necesesito

    method pasarASiguienteNivel() {
        nivelActual = nivelActual.siguienteNivel()   
        game.clear()         
        self.iniciarJuego()
    }

    method validarPasarASiguienteNivel(){
        if(!managerEnemigos.hayEnemigos()){
            self.pasarASiguienteNivel()
        }
    }

    method terminarJuegoPerdido() {
        onTicks.parar()
        musicaInicio.sacarMusica()
        config.keybindReinicio()
        game.addVisual(fondoGameOver)
        game.schedule(3000, { self.reiniciarJuego() })
    }

    method reiniciarJuego() {
        naveJugador.restart()
        musicaInicio.iniciar()
        self.pasarASiguienteNivel()
    }
}