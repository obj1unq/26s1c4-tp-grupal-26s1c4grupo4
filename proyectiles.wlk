import managers.*
import jugador.*

class Proyectil{
    method mover()
    method chocar(objeto)

    method inicializarColision(){
        game.onCollideDo(self, ({objeto => self.chocar(objeto)}))
    }
}

class ProyectilJugador inherits Proyectil{
    var property position  
    const property image = "proyectil-jugador.png"

    override method mover(){
        if(! self.alBorde()){
            position = game.at(self.position().x(), self.position().y()+1)
        }else{
            managerProyectiles.remover(self)
        }
    }
    override method chocar(objeto){
        objeto.colision()
        managerProyectiles.remover(self) 
    }
    method alBorde(){
        return self.position().y() + 1 == game.height()
    }
    method colision(){
        
    }
}
class ProyectilEnemigo inherits Proyectil{
    var property position   
    var property image = "proyectil-enemigo.png"

    override method mover(){
        if(! self.alBorde()){
            position = game.at(self.position().x(), self.position().y()-1)
        }else{
            managerProyectiles.remover(self)
        }
    }
    override method chocar(objeto){
        objeto.colision()
        managerProyectiles.remover(self) 
    }
    method alBorde(){
        return self.position().y() - 1 == 0 
    }
    method colision(){
        
    }
}
