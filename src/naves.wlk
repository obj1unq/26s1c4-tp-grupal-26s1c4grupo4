import src.sonido.*
import manager.*
import proyectil.*
import hud.*
import wollok.game.*
import config.*

class Nave{
    var property position
    var property vidas
    var puedeDisparar = true 
    const tiempoEntreDisparos = 200

    method image() = "nave" + self.indicadorImagen() + ".png"

    method indicadorImagen()

    method disparar(){
        if (puedeDisparar) {
            const proyectil = self.nuevoProyectil()
            managerProyectiles.agregar(proyectil)
            
            puedeDisparar = false
            
            // Pasados los 300 milisegundos, volvemos a habilitar el disparo
            game.schedule(tiempoEntreDisparos, { puedeDisparar = true })
        }
    }

    method nuevoProyectil() 

    method posicionProyectil(){
        return game.at(self.position().x(), self.position().y() + self.indicadorPosicion())
    } 

    method indicadorPosicion()

    method recibirImpactoJugador(proyectil) {}

    method recibirImpactoEnemigo(proyectil) {}

    method recibirVidaExtra(item) {}

    method colision(){
        self.sonidoColision()
        self.restarVida()
        self.verificarVidas()
    }

    method sonidoColision()

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

    override method disparar(){
        super()
        self.reproducirSonidoDisparoSiSePuede()
    }

    method reproducirSonidoDisparoSiSePuede(){
        if (!puedeDisparar) {
            sonidoDisparo.play()
        }
    }

    override method sonidoColision(){
        sonidoExplosionJugador.play()
    }
 
    method restart(){
        self.vidas(3)
        self.position(self.posicionInicial())
    }

    method posicionInicial() = game.at(7,1)

    method sumarVida() {
     if (vidas < 3) {
            vidas +=  1
        }
    }

    override method recibirImpactoEnemigo(proyectil) {
        self.colision()                  // Resta vida, sonido, chequea muerte
        managerProyectiles.remover(proyectil) // Elimina el proyectil
    }

    // Al jugador le beneficia la vida extra
    override method recibirVidaExtra(item) {
        self.sumarVida()
        managerProyectiles.remover(item)
    }

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

    override method sonidoColision(){
        sonidoExplosionEnemigo.play()
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

    override method recibirImpactoJugador(proyectil) {
        self.colision()
        managerProyectiles.remover(proyectil)
    }
}

class NaveEnemigoAvanzado inherits NaveEnemigoInicial{ //Este enemigo tiene dos vidas
    override method indicadorImagenEnemigo() = "Avanzado"

    override method vidaEnemigo() = 2

    override method sonidoColision(){
        if(self.estaViva()){
            sonidoDanioEnemigo.play()
        } 
    }
    
    override method morir(){
        managerEnemigos.registrarSpawnPendiente()
        super()
        game.schedule(700, {managerEnemigos.agregar(new NaveEnemigoInicial(position = self.position()))})
    }
}
