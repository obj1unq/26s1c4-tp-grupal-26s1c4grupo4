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

    method colision(){}
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

    method spawnearEnemigoInicial(posicion){
        const enemigoInicial = new NaveEnemigoInicial(position = posicion)
        managerEnemigos.agregar(enemigoInicial)
        game.onCollideDo(enemigoInicial, {colisionado => colisionado.colisionarEnemigo(enemigoInicial)})
    }

    method spawnearEnemigoAvanzado(posicion){
        const enemigoAvanzado = new NaveEnemigoAvanzado(position = posicion)
        managerEnemigos.agregar(enemigoAvanzado)
    }

    method spawnearEnemigosIniciales()

    method spawnearEnemigosAvanzados()

    method spawnearEnemigosMixtos(){
        self.spawnearEnemigosIniciales()
        self.spawnearEnemigosAvanzados()
    }
}

class PatronCuatroEnemigos inherits PatronEnemigos{
    var property nuevoValorX
    var property nuevoValorY

    override method spawnearEnemigosIniciales(){
        self.spawnearEnemigoInicial(self.configurarPosicion(12 + nuevoValorX, nuevoValorY)) //limite +
        self.spawnearEnemigoInicial(self.configurarPosicion(5 + nuevoValorX, nuevoValorY))
        self.spawnearEnemigoInicial(self.configurarPosicion(-5 + nuevoValorX, nuevoValorY))
        self.spawnearEnemigoInicial(self.configurarPosicion(-12 + nuevoValorX, nuevoValorY))  //limite -
    }

    override method spawnearEnemigosAvanzados(){
        self.spawnearEnemigoAvanzado(self.configurarPosicion(nuevoValorX, 10 + nuevoValorY)) //limite +
        self.spawnearEnemigoAvanzado(self.configurarPosicion(nuevoValorX, 5 + nuevoValorY))
        self.spawnearEnemigoAvanzado(self.configurarPosicion(nuevoValorX, 0 + nuevoValorY))
        self.spawnearEnemigoAvanzado(self.configurarPosicion(nuevoValorX, -8 + nuevoValorY))  //limite -
    }
}

object patronHorizontalBasico1 inherits PatronCuatroEnemigos(nuevoValorX = 1, nuevoValorY = 0){}

object patronHorizontalBasico2 inherits PatronCuatroEnemigos(nuevoValorX = 0, nuevoValorY = 4){}

object patronHorizontalBasico3 inherits PatronCuatroEnemigos(nuevoValorX = -1, nuevoValorY = 8){}

object patronVerticalAvanzado1 inherits PatronCuatroEnemigos(nuevoValorX = -1, nuevoValorY = 2){}

object patronVerticalAvanzado2 inherits PatronCuatroEnemigos(nuevoValorX = 5, nuevoValorY = 4){}

object patronVerticalAvanzado3 inherits PatronCuatroEnemigos(nuevoValorX = 9, nuevoValorY = 4){}


//Actualizacion: 
/*el spawn de enemigos funciona hay que mejorar assets y mejorar los patrones de aparicion 
lo siguiente a hacer es pensar como se puede seleccionar el patron de una lista, asi genera uno aleatorio y despues, cuando el 
jugador haya eliminado todos los enemigos, seleccionar otro 
lo que estoy pensando es, agregar un tick que verifique que la lista de enemigos sea vacia y cuando lo sea, spawnee otro patron 
*/
/*Falta modelar el comportamiento de los enemigos, por ejemplo la frecuencia de 
disparo, frecuencia de movimiento frecuencia de spawn
LO SIGUIENTE A HACER VA A SER EL COMPORTAMIENTO DE LOS ENEMIGOS*/

