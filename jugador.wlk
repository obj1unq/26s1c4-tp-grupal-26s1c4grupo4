import managers.*
import proyectiles.*
import hud.*
import gameover.*

object jugador{
    var property vidas = 3 
    var property position = game.at(7,1)


    method image(){
        return "nave-jugador.png"
    }

    method disparar(){
        const proyectil = new ProyectilJugador(position = self.positionP())
        managerProyectiles.agregar(proyectil)
        proyectil.inicializarColision()
    }
    method positionP(){
        return game.at(self.position().x(), self.position().y() +1)
    } 
    method colision(){
        self.restarVida()
        game.say(self, "Funciona")
    
    if (!self.estaViva()) {
            gestorJuego.terminarJuego()
        }
    }
 
    method restart(){
        self.vidas(3)
        self.position(game.at(7,0))
        self.limpiarTablero()
    }
    method limpiarTablero(){
        managerEnemigos.limpiar()
        managerProyectiles.limpiar()
    }
//Methods relacionados con las vidas de la nave 
   method restarVida(){
        vidas = vidas - 1 
   }
   method estaViva(){
        return vidas > 0 
   }
   method verificarVidas(){

/*Aca quiero que, si no tiene mas vidas, pare el juego*/
    if(! self.estaViva()){
        game.stop()
    }
   }
}