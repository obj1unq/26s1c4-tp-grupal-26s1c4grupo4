import manager.*
import naves.*


// sacar el oncolide de proyectil, ponerlo en nave
class Proyectil{
    var property position

    method image() = "proyectil" + self.indicadorImagen() + ".png"

    method indicadorImagen() 

    method mover(){
        if(!self.alBorde()){
            position = game.at(self.position().x(), self.position().y() + self.indicadorPosicion())
        } else {
            managerProyectiles.remover(self)
        }
    }

    method alBorde(){
        return self.position().y() + self.indicadorPosicion() == game.height()
    }

    method indicadorPosicion() 

    method chocar(objeto){
        objeto.colision()
        managerProyectiles.remover(self) 
    }

    method limpiarSiEsInvisible(){
        if(self.esUnoInvisible()){
            managerProyectiles.remover(self)
        }
    }

    method esUnoInvisible()

    method colision(){}
}

class ProyectilJugador inherits Proyectil{
    override method indicadorImagen() = "Jugador"

    override method indicadorPosicion() = +1
    
    method colisionarEnemigo(enemigo){
        enemigo.colision()
    }

    override method esUnoInvisible() = self.position().y() > 50
}

class ProyectilEnemigo inherits Proyectil{
     override method indicadorImagen() = "Enemigo"

    override method indicadorPosicion() = -1
    
    method colisionasteJugador(jugador){
        jugador.colision()
    }

    method colisionarEnemigo(enemigo){}

    override method esUnoInvisible() = self.position().y() < -10
}

class VidaExtra inherits Proyectil {
    override method indicadorImagen() = ""

    override method image() = "corazon1.png" 

    // Va para abajo, por lo que su desplazamiento en Y es negativo (igual que el proyectil enemigo)
    override method indicadorPosicion() = -1

    // Se limpia sola si el jugador no la agarra y pasa el límite de la pantalla
    override method esUnoInvisible() = self.position().y() < -10

    method colisionasteJugador(jugador) {
     jugador.sumarVida()               // Le da el beneficio al jugador
     managerProyectiles.remover(self)  // Se elimina a sí misma usando el manager existente
    }
}
