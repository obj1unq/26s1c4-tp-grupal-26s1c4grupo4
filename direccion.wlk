import wollok.game.*
import nave.*
import enemigo.*

class Direccion{
    method mover(pj)
    method siguientePosicion(posicion)   
}

object derecha inherits Direccion{
    override method mover(pj){
      pj.position(self.siguientePosicion(pj.position()))
    }

    override method siguientePosicion(posicion){
        return game.at(posicion.x() + 1, posicion.y())
    }
    
}

object izquierda inherits Direccion{
    override method mover(pj){
      pj.position(self.siguientePosicion(pj.position()))

    }
    override method siguientePosicion(posicion){
        return game.at(posicion.x() - 1, posicion.y())
    }

}

object arriba inherits Direccion {
    
    override method mover(pj) {
        pj.position(self.siguientePosicion(pj.position()))
    }

    override method siguientePosicion(posicion) {
        return game.at(posicion.x(), posicion.y() + 1)
    }

}

object abajo inherits Direccion {

    override method mover(pj) {
        pj.position(self.siguientePosicion(pj.position()))
    }

    override method siguientePosicion(posicion) {
        return game.at(posicion.x(), posicion.y() - 1)
    }
}