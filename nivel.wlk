import wollok.game.*
import nave.*
import direccion.*

  object configuracion{
    method keybinds(){
  keyboard.up().onPressDo({arriba.mover(nave)})           //moverse derecha
  keyboard.down().onPressDo({abajo.mover(nave)})          //moverse izquierda
  keyboard.right().onPressDo({derecha.mover(nave)})       //moverse derecha
  keyboard.left().onPressDo({izquierda.mover(nave)})      //moverse izquierda
  keyboard.c().onPressDo({nave.disparar()})                    //disparar
  //keyboard.r().onPressDo({nave.restart()})                     //restart
    
    }
}

