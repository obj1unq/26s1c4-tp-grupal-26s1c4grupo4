import naves.*
import manager.*

object contadorVidas{
    const position = game.at(27,30)

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

    method spawnearEnemigosMixtos1(){
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(6 + nuevoValorX, nuevoValorY))) 
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(0 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(-6 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(-12 + nuevoValorX, nuevoValorY))) 
    }

    method spawnearEnemigosMixtos2(){
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(6 + nuevoValorX, nuevoValorY))) 
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(0 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoAvanzado(position = self.configurarPosicion(-6 + nuevoValorX, nuevoValorY)))
        self.spawnearEnemigo(new NaveEnemigoInicial(position = self.configurarPosicion(-12 + nuevoValorX, nuevoValorY)))
    }
}

object patronHorizontal1 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = 3, nuevoValorY = 8){}
object patronHorizontal2 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = 0, nuevoValorY = 4){}
object patronHorizontal3 inherits PatronHorizontalCuatroEnemigos(nuevoValorX = -3, nuevoValorY = 0){}


