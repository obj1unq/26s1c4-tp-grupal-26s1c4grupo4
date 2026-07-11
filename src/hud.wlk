import naves.*
import manager.*

object contadorVidas{
    const position = game.at(25,30)

    method image(){
        return "corazon" + naveJugador.vidas() + ".png"
    }
    method position(){
        return position 
    }
}

class Fondo{
    var property indicadorFondo = ""

    method position() = game.at(0, 0)

    method image() = "fondo" + indicadorFondo + ".png"
}

object fondo inherits Fondo{}
object fondoFinal inherits Fondo(indicadorFondo = "Final"){}
object fondoGameOver inherits Fondo(indicadorFondo = "GameOver") {}
object fondoInicial inherits Fondo(indicadorFondo = "Inicial") {}


/*Mi idea es hacer que los enemigos vayan apareciendo en dsitintas formas, por 
ejemplo en patrones, voy a empezar a definirlos como WKO y veo si despues los paso a 
clases, por ahora voy a hacer 1 patron y luego agregar mas*/

class PatronEnemigos{
    var property posicionInicial = game.center()

    method configurarPosicion(valorX, valorY){
        return game.at(posicionInicial.x() + valorX, posicionInicial.y() + valorY)
    }

    method spawnearEnemigo(enemigo){
        managerEnemigos.agregar(enemigo)
    }
}

class PatronHorizontalCuatroEnemigos inherits PatronEnemigos{
    var property nuevoValorX
    var property nuevoValorY

    method spawnearEnemigosIniciales(){
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(6 + nuevoValorX, nuevoValorY))) 
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(0 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(-6 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(-12 + nuevoValorX, nuevoValorY)))
    }

    method spawnearEnemigosAvanzados(){
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(6 + nuevoValorX, nuevoValorY))) 
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(0 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(-6 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(-12 + nuevoValorX, nuevoValorY))) 
    }

}

object patronHorizontal1 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = 3, nuevoValorY = 0){}

object patronHorizontal2 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = 0, nuevoValorY = 4){}

object patronHorizontal3 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = -3, nuevoValorY = 8){}


//Actualizacion: 
/*el spawn de enemigos funciona hay que mejorar assets y mejorar los patrones de aparicion 
lo siguiente a hacer es pensar como se puede seleccionar el patron de una lista, asi genera uno aleatorio y despues, cuando el 
jugador haya eliminado todos los enemigos, seleccionar otro 
lo que estoy pensando es, agregar un tick que verifique que la lista de enemigos sea vacia y cuando lo sea, spawnee otro patron 
*/
/*Falta modelar el comportamiento de los enemigos, por ejemplo la frecuencia de 
disparo, frecuencia de movimiento frecuencia de spawn
LO SIGUIENTE A HACER VA A SER EL COMPORTAMIENTO DE LOS ENEMIGOS*/

