import wollok.game.*

object izquierda{
  method siguiente(position) = if(position.x() > 0) position.left(1) else self.error("No se puede Mover")

}

object derecha{
  method siguiente(position) = if(position.x() < (game.width() - 1)) position.right(1) else self.error("No se puede Mover")
}
