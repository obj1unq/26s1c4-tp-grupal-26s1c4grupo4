import proyectil.*

object nave{
    var property position = game.at(8,0)

    method image(){
        return "nave.png"
    }

	method mover(direccion) {
		position = direccion.siguiente(position)
    }

    method disparar(){
        const proyectilNave = new Proyectil(position = self.position().up(1), image = "disparoN.png", esEnemigo = false)
        proyectilNave.iniciar(100)
    }

    method recibirImpacto() {
        game.stop()       
    }
}