import manager.*
import proyectil.*
import hud.*
import wollok.game.*
import config.*

class Nave{
    var property position

    method image() = "nave" + self.indicadorImagen() + ".png"

    method indicadorImagen()

    method disparar(){
        const proyectil = self.nuevoProyectil()
        managerProyectiles.agregar(proyectil)
        proyectil.inicializarColision()
    }

    method nuevoProyectil() 

    method posicionProyectil(){
        return game.at(self.position().x(), self.position().y() + self.indicadorPosicion())
    } 

    method indicadorPosicion()

    method colision()
}

object naveJugador inherits Nave(position = game.at(7, 1)){
    var property vidas = 3 

    override method indicadorImagen() = "Jugador"

    override method nuevoProyectil() = new ProyectilJugador(position = self.posicionProyectil())

    override method indicadorPosicion() = +1
 
    override method colision(){
        self.restarVida()
        self.verificarVidas()
    }
 
    method restart(){
        self.vidas(3)
        self.position(self.posicionInicial())
        self.limpiarTablero()
    }

    method limpiarTablero(){
        managerEnemigos.limpiar()
        managerProyectiles.limpiar()
    }

    //Methods relacionados con las vidas de la nave 
    method restarVida(){
        vidas = vidas - 1 
    }

    method estaViva(){
        return vidas > 0 
    }

    method verificarVidas(){
        if(!self.estaViva()){
            managerJuego.terminarJuegoPerdido()
        }
    }

    method posicionInicial() = game.at(7,1)
}

class NaveEnemigoInicial inherits Nave{
    var movioDerecha = true

    override method indicadorImagen() = "Enemigo" + self.indicadorImagenEnemigo()

    method indicadorImagenEnemigo() = "Inicial"

    override method nuevoProyectil() = new ProyectilEnemigo(position = self.posicionProyectil())

    override method indicadorPosicion() = -1


    //Colision con objetos 
    override method colision(){
        managerEnemigos.remover(self) 
    }

    method mover(direccion){
        direccion.mover(self)
    }
	
	method moverse(){
        if(movioDerecha){
            self.mover(derecha)
            movioDerecha = false
        } else {
            self.mover(izquierda)
            movioDerecha = true
        }
    }
}

class NaveEnemigoAvanzado inherits NaveEnemigoInicial{ //Este enemigo tiene dos vidas
    override method indicadorImagenEnemigo() = "Avanzado"
}
