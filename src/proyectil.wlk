import manager.*
import naves.*

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

    method inicializarColision(){
        game.onCollideDo(self, ({objeto => self.chocar(objeto)}))
    }
}

class ProyectilJugador inherits Proyectil{
    override method indicadorImagen() = "Jugador"

    override method indicadorPosicion() = +1

    method colision(){}
}
class ProyectilEnemigo inherits Proyectil{
     override method indicadorImagen() = "Enemigo"

    override method indicadorPosicion() = -1

    method colision(){}
}
