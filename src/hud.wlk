import naves.*

object contadorVidas{
    const position = game.at(25,30)

    method image(){
        return "corazon" + naveJugador.vidas() + ".png"
    }

    method position(){
        return position 
    }
}

 object pantallaGameOver {
    method image() = "fondoGameOver.png"

    method position() = fondo.position()
}

object fondo {
    var property imagen = "fondo.png"
    // El fondo siempre debe posicionarse en el origen (0,0)
    method position() = game.at(0, 0) 

    method image() = imagen
}