import wollok.game.*
import jugador.*
import enemigos.*

class Direccion {
  method mover(pj){
    pj.position(self.siguientePosicion(pj.position()))
  }

  method siguientePosicion(posicion) {
    return game.at(posicion.x() + self.incrementoX(), posicion.y() + self.incrementoY())
  }

  method incrementoX() = 0

  method incrementoY() = 0
}

object derecha inherits Direccion {
  override method incrementoX() = 1
}

object izquierda inherits Direccion {
  override method incrementoX() = -1
}

object arriba inherits Direccion {
  override method incrementoY() = 1
}

object abajo inherits Direccion {
  override method incrementoY() = -1
}