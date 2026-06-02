import wollok.game.*
import nave.*
import direccion.*
import extras.*

object juego{

    method configurarJuego(){
        self.configurarTeclas()
        self.agregarVisuales()
    }

    method configurarTeclas(){
 	    keyboard.left().onPressDo({nave.mover(izquierda)})
	    keyboard.right().onPressDo({nave.mover(derecha)})
	    keyboard.x().onPressDo({nave.disparar()})
    }

    method agregarVisuales(){
        game.addVisual(nave)
    }




}