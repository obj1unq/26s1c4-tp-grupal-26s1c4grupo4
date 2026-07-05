import wollok.game.*
import galaga.*
import naves.*
import proyectil.*
import config.*

object sonidoDisparo {
	method play() {
		game.sound("ost/fire.wav").play()
	}
}

object explosion {
	method play() {
		game.sound("ost/explosion.wav").play()
	}
}

object musicaInicio {
	const musicaInicio = game.sound("assets/start.wav")

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
		if (musicaInicio.paused()){musicaInicio.resume()}
		else{
		musicaInicio.volume(0.5)
		game.schedule(500, { musicaInicio.play()})}
	}

    //Es la musica de inicio del juego, se reproduce al iniciar el juego y se pausa cuando se inicia la partida. 
    //Si se reinicia el juego, se reanuda la musica de inicio.
}

object musicaDañoEnemigo{
    method play() {
		game.sound("ost/enemy_damage.wav").play()
	}
}

object musicaExplosionJugador{
    method play() {
        game.sound("ost/player_destroy.wav").play()
    }
}

object musicaExplosionEnemigo{
    method play() {
        game.sound("ost/enemy_destroy.wav").play()
    }
}