import src.galaga.*
import src.sonido.*
import nivel.*
import config.*
import hud.*
import naves.*
import proyectil.*

class Manager {
    const elementos = []

    method mover() {
        elementos.forEach({elemento => elemento.mover()})
    }

    method limpiar() {
        elementos.forEach({elemento => game.removeVisual(elemento) })
        elementos.clear()
    }

    method remover(elemento) {
        // Primero saco el visual, despues lo elimino de la lista (por las dudas de si pierde la referencia)
        game.removeVisual(elemento) 
        elementos.remove(elemento)
    }

    method agregar(elemento) {
        elementos.add(elemento)
        game.addVisual(elemento)
    }
}

object managerEnemigos inherits Manager {
    /* Este objeto se va a encargar de el comportamiento de todo lo relacionado a los enemigos */
    var enemigosDerrotados = 0 
    var enemigosPendientesPorSpawnear = 0

    method hayEnemigos() = !elementos.isEmpty() or enemigosPendientesPorSpawnear > 0

    override method remover(enemigo) {
        super(enemigo)
        self.sumarEnemigoDerrotado()
        self.spawnearVidaExtraAlDerrotarEnemigos(6, enemigo)
        managerJuego.validarPasarASiguienteNivel()
    }

    method sumarEnemigoDerrotado(){
        enemigosDerrotados += 1
    }

    method spawnearVidaExtraAlDerrotarEnemigos(numero, enemigo){
        if (self.puedeSpawnearVidaExtra(numero)) {
            self.spawnearVidaExtra(enemigo.position())
        }
    }

    method puedeSpawnearVidaExtra(numero) = enemigosDerrotados.rem(numero) == 0

    method spawnearVidaExtra(posicion) {
        const vida = new VidaExtra(position = posicion)
        managerProyectiles.agregar(vida)
    }

    method onTickDisparo() {
        const intervaloRandomDeDisparo = 1000.randomUpTo(3000) 
        return game.tick(intervaloRandomDeDisparo, {elementos.forEach({enemigo => enemigo.disparar()})}, true)
    }

    method onTickMovimiento() {
        const intervaloRandomDeMovimiento = 700.randomUpTo(1200) 
        return game.tick(intervaloRandomDeMovimiento, {elementos.forEach({enemigo => enemigo.moverse()})}, true)
    }

    override method agregar(enemigo) {
        super(enemigo)
        game.onCollideDo(enemigo, {objeto => objeto.colisionarCon(enemigo)})
        enemigosPendientesPorSpawnear = (enemigosPendientesPorSpawnear - 1).max(0)
    }

    method registrarSpawnPendiente() {
        enemigosPendientesPorSpawnear += 1
    }

    method cantidadEnemigos() = elementos.size()
}

object managerProyectiles inherits Manager {
    /* Este objeto de lo que se encarga es del comportamiento de todos los proyectiles, o sea de todo lo 
    relacionado que va a suceder en pantalla con ellos */

    method onTickVelocidadProyectiles() {
        const intervaloVelocidad = 70
        return game.tick(intervaloVelocidad, {self.mover()}, true)
    }

    method limpiarProyectilesInvisibles() {
        const intervaloLimpieza = 500 
        return game.tick(intervaloLimpieza, {elementos.forEach({proyectil => proyectil.limpiarSiEsInvisible()})}, true)
    }
}

object managerJuego {
    var property nivelActual = nivelInicial 

    method iniciarJuego() {
        nivelActual.iniciar()
    }

    method pasarASiguienteNivel() {
        self.limpiarTablero() 
        nivelActual = nivelActual.siguienteNivel()   
        self.iniciarJuego()
    }

    method validarPasarASiguienteNivel() {
        if (!managerEnemigos.hayEnemigos()) {
            self.pasarASiguienteNivel()
        }
    }

    method terminarJuegoPerdido() {
        config.juegoPerdido(true)
        onTicks.parar()
        config.keybindReinicio()
        game.addVisual(fondoGameOver)
        game.schedule(3000, { game.removeVisual(fondoGameOver) self.reiniciarJuego() })
    }

    method limpiarTablero() {
        managerEnemigos.limpiar()       
        managerProyectiles.limpiar() 
    }

    method reiniciarJuego() { 
        self.limpiarTablero()      // 1. Vaciamos enemigos y proyectiles
        musicaInicio.sacarMusica()
        nivelActual = nivelInicial // 2. Volvemos al nivel de introducción/inicial
        naveJugador.restart()      // 3. Reseteamos la nave usando 'restart()' como lo tenés en naves.wlk
        config.juegoPerdido(false)
        nivelActual.iniciar()      // 4. Arrancamos el nivel inicial de cero
    } 
}