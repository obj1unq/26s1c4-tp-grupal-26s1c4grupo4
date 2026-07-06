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
    /*Aca quiero que, si no tiene mas vidas, pare el juego*/
        if(! self.estaViva()){
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
        managerEnemigos.remover(self) /*aca podria apuntar con una var al manager en vez de usar la 
                                    referencia global, pero no lo veo necesario, el manager siempre va
                                    a ser el mismo*/
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

class NaveEnemigoAvanzado inherits NaveEnemigoInicial{
    override method indicadorImagenEnemigo() = "Avanzado"
}


/*Mi idea es hacer que los enemigos vayan apareciendo en dsitintas formas, por 
ejemplo en patrones, voy a empezar a definirlos como WKO y veo si despues los paso a 
clases, por ahora voy a hacer 1 patron y luego agregar mas*/
class PatronHorizontal{
    var property posicionInicial = game.center()



    method spawnearEnemigos(){
        //self.spawnearEnemigo(self.posicionInicial())
        self.spawnearEnemigo(game.at(posicionInicial.x()+1, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()-1, posicionInicial.y()))
    }
    method spawnearEnemigo(posicion){
        const enemigo = new NaveEnemigoInicial(position = posicion)
        managerEnemigos.agregar(enemigo)
    }
}

object patronHorizontal1 inherits PatronHorizontal{
    
    override method spawnearEnemigos(){
        //self.spawnearEnemigo(self.posicionInicial())
        self.spawnearEnemigo(game.at(posicionInicial.x()+9, posicionInicial.y()+3))
        self.spawnearEnemigo(game.at(posicionInicial.x()+5, posicionInicial.y()+3))
        self.spawnearEnemigo(game.at(posicionInicial.x()+1, posicionInicial.y()+3))
        self.spawnearEnemigo(game.at(posicionInicial.x()-1, posicionInicial.y()+3))
        self.spawnearEnemigo(game.at(posicionInicial.x()-5, posicionInicial.y()+3))
        self.spawnearEnemigo(game.at(posicionInicial.x()-9, posicionInicial.y()+3))
    }
}

object patronHorizontal2 inherits PatronHorizontal{
    
    override method spawnearEnemigos(){
        //self.spawnearEnemigo(self.posicionInicial())
        self.spawnearEnemigo(game.at(posicionInicial.x()+11, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()+7, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()+3, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()-3, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()-7, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()-11, posicionInicial.y()))
    }
}



object enemigoIndividual{
    var property posicionInicial = game.center()

    method spawnearEnemigos(){
        self.spawnearEnemigo(self.posicionInicial())
    }
    method spawnearEnemigo(posicion){
        const enemigo = new NaveEnemigoInicial(position =posicion)
        managerEnemigos.agregar(enemigo)
    }
}

//Actualizacion: 
/*el spawn de enemigos funciona hay que mejorar assets y mejorar los patrones de aparicion 
lo siguiente a hacer es pensar como se puede seleccionar el patron de una lista, asi genera uno aleatorio y despues, cuando el 
jugador haya eliminado todos los enemigos, seleccionar otro 
lo que estoy pensando es, agregar un tick que verifique que la lista de enemigos sea vacia y cuando lo sea, spawnee otro patron 
*/
/*Falta modelar el comportamiento de los enemigos, por ejemplo la frecuencia de 
disparo, frecuencia de movimiento frecuencia de spawn
LO SIGUIENTE A HACER VA A SER EL COMPORTAMIENTO DE LOS ENEMIGOS*/