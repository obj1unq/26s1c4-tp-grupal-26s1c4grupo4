import sonido.*

class Nivel{
    // nivelActual = 1

    method configuracionInicial(){ 
	    game.cellSize(32)
	    game.height(16)
	    game.width(16)
	    game.title("Galaga")
	    self.configuarBackground()
    }

    method configuarBackground{
        game.boardGround("background.png")
    }


    method iniciarJuego(){}




    /*method cambiarNivel() {
        nivelActual += 1
        if (nivelActual == 2) {
            // Configurar el segundo nivel
            segundoNivel.configurar()
        } else if (nivelActual == 3) {
            // Configurar el tercer nivel
            tercerNivel.configurar()
        } else {
            // Si no hay más niveles, finalizar el juego
            game.stop()
        }
    }*/


}

object nivelInicio inherits Nivel{

    method configurar(){
        // Configuración del nivel de inicio
        game.title("Nivel de Inicio")
        game.height(15)
        game.width(15)
        game.cellSize(225)
        game.boardGround("background-inicio.png")
        // Agregar enemigos, obstáculos, etc. para el nivel de inicio
    }

    method iniciarJuego(){
        game.clear()
        self.configuracionInicial()
        musicaInicio.play()
        game.start()
    }
}

object primerNivel inherits Nivel{



    method configurar(){
        // Configuración del primer nivel
        game.title("Nivel 1")
        game.height(15)
        game.width(15)
        game.cellSize(225)
        game.boardGround("background.png")
        // Agregar enemigos, obstáculos, etc. para el primer nivel
    }


}

object segundoNivel inherits Nivel{
    method configurar(){
        // Configuración del segundo nivel
        game.title("Nivel 2")
        game.height(15)
        game.width(15)
        game.cellSize(225)
        game.boardGround("background.png")
        // Agregar enemigos, obstáculos, etc. para el segundo nivel
    }
}