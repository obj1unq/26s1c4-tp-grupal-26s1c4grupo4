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

 object pantallaGameOver {
    // Lo ubicamos más o menos en el centro del tablero (que es de 16x16)
    method image() = "fondoGameOver.png"

    method position() = game.at(0, 0) 
}


object fondo {
    var property imagen = "fondo.png"
    // El fondo siempre debe posicionarse en el origen (0,0)
    method position() = game.at(0, 0) 

    method image() = imagen
}