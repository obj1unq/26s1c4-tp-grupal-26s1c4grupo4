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
    method position() = game.at(0, 0)

    method image()

    method ponerBackground(){
        game.addVisual(self)
    }
}

object pantallaGameOver inherits Fondo {
    // Lo ubicamos más o menos en el centro del tablero (que es de 16x16)
    override method image() = "fondoGameOver.png"
}

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
    }

    method spawnearEnemigoAvanzado(posicion){
        const enemigoAvanzado = new NaveEnemigoAvanzado(position = posicion)
        managerEnemigos.agregar(enemigoAvanzado)
    }

    method spawnearEnemigos()
}

class PatronHorizontalInicial inherits PatronEnemigos{

    override method spawnearEnemigos(){
        self.spawnearEnemigoInicial(self.configurarPosicion(12, self.valorY())) //limite +
        self.spawnearEnemigoInicial(self.configurarPosicion(4, self.valorY()))
        self.spawnearEnemigoInicial(self.configurarPosicion(-4, self.valorY()))
        self.spawnearEnemigoInicial(self.configurarPosicion(-12, self.valorY()))  //limite -
    }

    method valorY()
}

object patronHorizontalBasico1 inherits PatronHorizontalInicial{
    override method valorY() = 0
}

object patronHorizontalBasico2 inherits PatronHorizontalInicial{
    override method valorY() = 4
}

object patronHorizontalBasico3 inherits PatronHorizontalInicial{
    override method valorY() = 8
}

class PatronVerticalAvanzado inherits PatronEnemigos{

    override method spawnearEnemigos(){
        self.spawnearEnemigoAvanzado(self.configurarPosicion(self.valorX(), 10)) //limite +
        self.spawnearEnemigoAvanzado(self.configurarPosicion(self.valorX(), 5))
        self.spawnearEnemigoAvanzado(self.configurarPosicion(self.valorX(), 0))
        self.spawnearEnemigoAvanzado(self.configurarPosicion(self.valorX(), -8))  //limite -
    }

    method valorX()
}

object patronVerticalAvanzado1 inherits PatronVerticalAvanzado{
    override method valorX() = -1
}

object patronVerticalAvanzado2 inherits PatronVerticalAvanzado{
    override method valorX() = 5
}

object patronVerticalAvanzado3 inherits PatronVerticalAvanzado{
    override method valorX() = 9
}

//Actualizacion: 
/*el spawn de enemigos funciona hay que mejorar assets y mejorar los patrones de aparicion 
lo siguiente a hacer es pensar como se puede seleccionar el patron de una lista, asi genera uno aleatorio y despues, cuando el 
jugador haya eliminado todos los enemigos, seleccionar otro 
lo que estoy pensando es, agregar un tick que verifique que la lista de enemigos sea vacia y cuando lo sea, spawnee otro patron 
*/
/*Falta modelar el comportamiento de los enemigos, por ejemplo la frecuencia de 
disparo, frecuencia de movimiento frecuencia de spawn
LO SIGUIENTE A HACER VA A SER EL COMPORTAMIENTO DE LOS ENEMIGOS*/

