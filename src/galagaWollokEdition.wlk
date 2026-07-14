import wollok.game.*
import nivel.*

object galagaWollokEdition {
  method iniciar() {
    game.cellSize(32)
    game.height(32)
    game.width(32)
    game.title("Galaga Wollok Edition")
    nivelInicial.iniciar()
    game.start()
  }
}



