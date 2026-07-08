import src.sonido.*
import manager.*
import proyectil.*
import hud.*
import wollok.game.*
import config.*

class Nave{
    var property position
    var property vidas

    method image() = "nave" + self.indicadorImagen() + ".png"

    method indicadorImagen()

    method disparar(){
        const proyectil = self.nuevoProyectil()
        sonidoDisparo.play()
        managerProyectiles.agregar(proyectil)
    }

    method nuevoProyectil() 

    method posicionProyectil(){
        return game.at(self.position().x(), self.position().y() + self.indicadorPosicion())
    } 

    method indicadorPosicion()

    method colision(){
        self.restarVida()
        self.verificarVidas()
    }

    method colisionarEnemigo(enemigo){}


    //Methods relacionados con las vidas de la nave 
    method restarVida(){
        vidas = vidas - 1 
    }

    method estaViva(){
        return vidas > 0 
    }

    method verificarVidas(){
        if(!self.estaViva()){
            self.morir()
        }
    }

    method morir()
}

object naveJugador inherits Nave(position = game.at(7, 1), vidas = 3){

    override method indicadorImagen() = "Jugador"

    override method nuevoProyectil() = new ProyectilJugador(position = self.posicionProyectil())

    override method indicadorPosicion() = +1

    override method morir(){
        managerJuego.terminarJuegoPerdido()
    }
 
    method restart(){
        self.vidas(3)
        self.position(self.posicionInicial())
    }

    method posicionInicial() = game.at(7,1)
}

class NaveEnemigoInicial inherits Nave(vidas = self.vidaEnemigo()){ 
    var movioDerecha = true

    override method indicadorImagen() = "Enemigo" + self.indicadorImagenEnemigo()

    method indicadorImagenEnemigo() = "Inicial"

    override method nuevoProyectil() = new ProyectilEnemigo(position = self.posicionProyectil())

    override method indicadorPosicion() = -1

    method vidaEnemigo() = 1

    override method morir(){
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

    override method vidaEnemigo() = 2
    
    override method morir(){
        super()
        game.schedule(1000, {managerEnemigos.agregar(new NaveEnemigoInicial(position = self.position()))})
    }
}
