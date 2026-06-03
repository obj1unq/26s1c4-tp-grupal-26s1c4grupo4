import wollok.game.*
import nave.*
import direccion.*
import extras.*
import enemigo.*

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
        self.enemigoA()

    }


    method enemigoA(){
        const enemigoA = new Enemigo (vida = 1)
        game.addVisual(enemigoA)
        game.onTick(2000, "dispararEnemigoA", { enemigoA.disparar() })
    }



}