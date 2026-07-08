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
}

class ProyectilJugador inherits Proyectil{
    override method indicadorImagen() = "Jugador"

    override method indicadorPosicion() = +1

    method colision(){}

    method colisionarEnemigo(enemigo){
        enemigo.colision()
    }

    override method esUnoInvisible() = self.position().y() > 50
}

class ProyectilEnemigo inherits Proyectil{
     override method indicadorImagen() = "Enemigo"

    override method indicadorPosicion() = -1

    method colision(){}

    method colisionasteJugador(jugador){
        jugador.colision()
    }

    method colisionarEnemigo(enemigo){}

    override method esUnoInvisible() = self.position().y() < -10
}
