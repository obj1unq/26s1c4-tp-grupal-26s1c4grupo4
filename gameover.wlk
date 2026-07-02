import hud.*
import jugador.*
import managers.*
import config.*
import wollok.game.*



object gestorJuego {
    method terminarJuego() {
        // 1. Limpiamos todo
        game.clear() 
        // 2. Ponemos el fondo negro usando boardGround (así no rompe con strings)
        game.boardGround("fondo-negro.png")
        
        // 3. Agregamos los visuales (estos objetos deben existir en hud.wlk)
        game.addVisual(pantallaGameOver)
        game.addVisual(mensajeReinicio)
        keyboard.r().onPressDo({ self.reiniciarJuego() })
        
        // 4. Esperamos 3 segundos antes de permitir reiniciar si quisieras, 
        // pero como ahora usamos la tecla R, dejamos que el usuario decida.
    }

    method reiniciarJuego() {
        // 1. Limpiamos la pantalla de Game Over
        game.clear()
        
        // 2. Reiniciamos lógica de jugador
        jugador.restart()
        
        // 3. Re-dibujamos el escenario inicial
        game.boardGround("background.png")
        game.addVisual(jugador)
        game.addVisual(contadorVidas)
        config.keybinds()        
        // 4. Reactivamos los Ticks (esto es clave para que los enemigos vuelvan)
        onTicks.tick()
        
    }
}