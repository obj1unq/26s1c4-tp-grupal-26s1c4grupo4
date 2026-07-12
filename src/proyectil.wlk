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

    method colisionarCon(nave)

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

    override method colisionarCon(nave){
        nave.recibirImpactoJugador(self)
    }

    override method esUnoInvisible() = self.position().y() > 50
}

class ProyectilEnemigo inherits Proyectil{
    override method indicadorImagen() = "Enemigo"

    override method indicadorPosicion() = -1

    override method colisionarCon(nave) {
        nave.recibirImpactoEnemigo(self)
    }
    
    override method esUnoInvisible() = self.position().y() < -10
}

class VidaExtra inherits ProyectilEnemigo {
    override method indicadorImagen() = ""

    override method image() = "corazon1.png" 

    override method colisionarCon(nave) {
        nave.recibirVidaExtra(self)
    }
}
