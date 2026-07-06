import wollok.game.*
import nivel.*

object galaga {
  method iniciar() {
    game.cellSize(32)
    game.height(32)
    game.width(32)
    game.title("Galaga")
    nivelInicial.iniciar()
    game.start()
  }
}



