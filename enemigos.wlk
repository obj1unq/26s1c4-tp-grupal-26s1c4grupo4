import managers.*
import proyectiles.*
class Enemigo{
    var property position 
    var property image = "nave-enemigo.png"

    method disparar(){
        const proyectil = new ProyectilEnemigo(position = game.at(self.position().x(), self.position().y()-1))
        managerProyectiles.agregar(proyectil)
        proyectil.inicializarColision()
    }
    //Colision con objetos 
    method colision(){
        managerEnemigos.remover(self) /*aca podria apuntar con una var al manager en vez de usar la 
                                    referencia global, pero no lo veo necesario, el manager siempre va
                                    a ser el mismo*/
    }
}


/*Mi idea es hacer que los enemigos vayan apareciendo en dsitintas formas, por 
ejemplo en patrones, voy a empezar a definirlos como WKO y veo si despues los paso a 
clases, por ahora voy a hacer 1 patron y luego agregar mas*/
object patronHorizontal3{
    var property posicionInicial = game.center()

    method spawnearEnemigos(){
        self.spawnearEnemigo(self.posicionInicial())
        self.spawnearEnemigo(game.at(posicionInicial.x()+1, posicionInicial.y()))
        self.spawnearEnemigo(game.at(posicionInicial.x()-1, posicionInicial.y()))
    }
    method spawnearEnemigo(posicion){
        const enemigo = new Enemigo(position = posicion)
        managerEnemigos.agregar(enemigo)
    }
}



object enemigoIndividual{
    var property posicionInicial = game.center()

    method spawnearEnemigos(){
        self.spawnearEnemigo(self.posicionInicial())
    }
    method spawnearEnemigo(posicion){
        const enemigo = new Enemigo(position =posicion)
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