import nivel.*

class Manager{
    method mover()
    method limpiar()
}
object managerEnemigos inherits Manager{
/*Este objeto se va a encargar de el comportamiento de todo lo relacionado a los enemigos*/
    const enemigos = []

    override method mover(){
        enemigos.forEach({enemigo => enemigo.mover()})
    }
    method agregar(enemigo){
        enemigos.add(enemigo)
        game.addVisual(enemigo)
    }
    method remover(enemigo){
        //primero saco el visual, despues lo elimino de la lista (por las dudas de si pierde la referencia)
        game.removeVisual(enemigo) 
        enemigos.remove(enemigo)
    }
    override method limpiar(){
        enemigos.forEach({enemigo => enemigo.remover()})
    }
    method onTickDisparo(){
        const intervaloRandomDeDisparo = 4000.randomUpTo(7000) 
        return game.tick(intervaloRandomDeDisparo,{enemigos.forEach({enemigo => enemigo.disparar()})},true)
    }
}
object managerProyectiles inherits Manager{
/*Este objeto de lo que se encarga es del comportamiento de todos los proyectiles, o sea de todo lo 
relacionado que va a suceder en pantalla con ellos*/
    const proyectiles = [] // aca van a estar todos los proyectiles de la pantalla

    override method mover(){
        proyectiles.forEach({proyectil => proyectil.mover()})
    }
    method agregar(proyectil){
        proyectiles.add(proyectil)
        game.addVisual(proyectil)
    }
    method remover(proyectil){
        proyectiles.remove(proyectil)
        game.removeVisual(proyectil)
    }
    override method limpiar(){
        proyectiles.forEach({proyectil => proyectil.remove()})
    }

}

object managerJuego {
    var nivelActual = nivelPresentación

    method iniciarJuego() {
        nivelActual.iniciar()
    }

    method pasarASiguienteNivel(nuevoNivel) {
        game.clear()              // 1. Borra todo lo que está en pantalla (visuales y fondo anterior)
        nivelActual = nuevoNivel  // 2. Actualiza la referencia del nivel
        nivelActual.iniciar()     // 3. Carga el nuevo fondo y los nuevos personajes
    }
}