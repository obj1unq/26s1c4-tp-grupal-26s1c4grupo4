object nave{
    var property position = game.at(0,0)

    method image(){
        return "nave.png"
    }

	method mover(direccion) {
		position = direccion.siguiente(position)
    }

    method disparar(){
        var disparo = new Proyectil(position.up(1))
        game.addVisual(disparo)
    }

}


class Proyectil{
    var property position

    constructor(pos){
        position = pos
    }

    method image(){
        return "disparo.png"
    }

    method onTick(){
        if(position.y() > 0){
            position = position.up(1)
        } else {
            game.removeVisual(self)
        }
    }
}