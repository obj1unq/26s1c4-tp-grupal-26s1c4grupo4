import wollok.game.*
import galaga.*
import naves.*
import proyectil.*
import config.*

object musicaInicio {
	const musicaInicio = game.sound("ostStart.wav")

	method sacarMusica() {
		musicaInicio.stop()
	}

	method reiniciar() {
		musicaInicio.resume()
	}

	method play() {
		musicaInicio.play()
	}

	method iniciar() {
		game.schedule(100, { musicaInicio.play() musicaInicio.volume(0.3) })
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
