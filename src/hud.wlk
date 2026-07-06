import naves.*

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

class Background{
    method position() = game.at(0, 0)

    method image()

    method ponerBackground(){
        game.addVisual(self)
    }
}

object pantallaGameOver inherits Background {
    // Lo ubicamos más o menos en el centro del tablero (que es de 16x16)
    override method image() = "fondoGameOver.png"
}
