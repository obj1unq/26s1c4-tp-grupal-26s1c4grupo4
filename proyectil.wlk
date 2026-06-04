class Proyectil{
    var property position
    var property image
    const esEnemigo

    method iniciar(tiempo){
        game.addVisual(image)
        game.onTick(tiempo, "moverProyectil", { self.moverse() })
        game.onCollideDo("objetivo", { objeto => self.impactar(objeto) })
    }

    method moverse() {
        if (esEnemigo) {
            position = position.down(1)
        } else {
            position = position.up(1)   
        }
    }

   method impactar(objeto) {
        objeto.recibirImpacto() 
        self.desaparecer()
    }

    method desaparecer() {
        game.removeTickEvent("moverProyectil")
        game.removeVisual(image)
    }
}