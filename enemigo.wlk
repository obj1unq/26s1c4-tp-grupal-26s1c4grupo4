import nave.*
import proyectil.*

class Enemigo {
    var property vida 

    method position()

    method image()

    method disparar() {
        const proyectilEnemigo = new Proyectil(position = self.position().down(1), image = "disparoE.png", esEnemigo = true)
        proyectilEnemigo.iniciar(500)
    }

    method recibirImpacto() {
        vida -= 1
        self.destruirSiEsNecesario()
    }

    method destruirSiEsNecesario() {
        if (vida <= 0) {
            self.destruir()
        }
    }

    method destruir() {
        game.removeVisual(self)
    }
}

class EnemigoA inherits Enemigo{

    override method image() {
        return "enemigoA.png"
    }
}

class EnemigoB inherits Enemigo {

    override method image() {
        return "enemigoB.png"
    }
}

class EnemigoC inherits Enemigo {

    override method image() {
        return "enemigoC.png"
    }
}

class EnemigoD inherits Enemigo {
 
    override method image() {
        return "enemigoD.png"
    }
}