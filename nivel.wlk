import wollok.game.*
import personaje.*
import direcciones.*

  object configuracion{
    method keybinds(){
  keyboard.up().onPressDo({arriba.mover(pj)})           //moverse derecha
  keyboard.down().onPressDo({abajo.mover(pj)})          //moverse izquierda
  keyboard.right().onPressDo({derecha.mover(pj)})       //moverse derecha
  keyboard.left().onPressDo({izquierda.mover(pj)})      //moverse izquierda
  keyboard.c().onPressDo({pj.disparar()})                    //disparar
  keyboard.r().onPressDo({pj.restart()})                     //restart
    
    }
}

