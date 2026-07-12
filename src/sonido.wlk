import wollok.game.*
import galaga.*
import naves.*
import proyectil.*
import config.*

object musicaInicio {
	const musicaInicio = game.sound("ostStart.wav")
	var property reproduciendo = false

	method sacarMusica() {
		if(self.reproduciendo()) {
			musicaInicio.stop()
			self.reproduciendo(false)
		}
	}

	method reiniciar() {
		musicaInicio.resume()
		self.reproduciendo(true)
	}

	method play() {
		musicaInicio.play()
		self.reproduciendo(true)
	}

	method iniciar() {
		game.schedule(100, { musicaInicio.play() musicaInicio.volume(0.5) self.reproduciendo(true) })
	}

    //Es la musica de inicio del juego, se reproduce al iniciar el juego y se pausa cuando se inicia la partida. 
    //Si se reinicia el juego, se reanuda la musica de inicio.
}

class Sonido{
	const nombreSonido
	
	method sonido() = game.sound("ost" + nombreSonido + ".wav")

	method play(){
		self.sonido().play()
	}
}

object sonidoDisparo inherits Sonido(nombreSonido = "Fire"){}
object sonidoDanioEnemigo inherits Sonido(nombreSonido = "EnemyDamage"){}
object sonidoExplosionJugador inherits Sonido(nombreSonido = "PlayerDestroy"){}
object sonidoExplosionEnemigo inherits Sonido(nombreSonido = "EnemyDestroy"){}
