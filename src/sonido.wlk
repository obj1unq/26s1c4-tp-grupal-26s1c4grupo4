import wollok.game.*
import galaga.*
import naves.*
import proyectil.*
import config.*

object sonidoDisparo {
	method play() {
		game.sound("ostFire.wav").play()
	}
}

object musicaInicio {
	const musicaInicio = game.sound("ostStart.wav")

	method sacarMusica() {
		musicaInicio.pause()
	}

	method reiniciar() {
		musicaInicio.resume()
	}

	method play() {
		musicaInicio.play()
	}

	method iniciar() {
		if(musicaInicio.paused()){
			musicaInicio.resume()
		} else {
			game.schedule(1, { musicaInicio.play() })
		}
	}

    //Es la musica de inicio del juego, se reproduce al iniciar el juego y se pausa cuando se inicia la partida. 
    //Si se reinicia el juego, se reanuda la musica de inicio.
}

object musicaDañoEnemigo{
    method play() {
		game.sound("ostEnemyDamage.wav").play()
	}
}

object musicaExplosionJugador{
    method play() {
        game.sound("ostPlayerDestroy.wav").play()
    }
}

object musicaExplosionEnemigo{
    method play() {
        game.sound("ostEnemyDestroy.wav").play()
    }
}