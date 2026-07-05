import naves.*

object contadorVidas{
    const position = game.at(25,30)

    method image(){
        return "corazon" + naveJugador.vidas() + ".png"
    }
    method position(){
        return position 
    }
    method colision(){
    }

    /*method position(){
        return game.at(0,15)
    }
    method text(){
        return ""+jugador.vidas() 
    }
    method textColor(){
        return "FF0000FF"
    }*/

}
 object pantallaGameOver {
    // Lo ubicamos más o menos en el centro del tablero (que es de 16x16)
    method image() = "fondoGameOver.png"

    method position() = game.at(0, 0) 
}

object mensajeReinicio {
    // Lo ubicamos un poco más abajo del cartel de game over
    method position() = game.at(game.center().x() - 3, game.center().y() - 3)
    method text() = "Presiona R para reiniciar"
    method textColor() = "000000"
}

object fondo {
    var property imagen = "fondo.png"
    // El fondo siempre debe posicionarse en el origen (0,0)
    method position() = game.at(0, 0) 

    method image() = imagen
}