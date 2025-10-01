extends JadeState

var direction := Vector2.ZERO


func enter(_previous_state_path: String, _data := {}) -> void:
	jade.velocity = Vector2.ZERO
	jade_hurtbox = jade.hurtbox
	jade_player = jade.anim_player
	jade_player.play("IDLE")

func physics_update(_delta: float) -> void:
	direction = Input.get_vector("move_left","move_right",
									 "move_up","move_down")
	
	jade.velocity = direction * jade.speed
	
	if jade.velocity.length() >= 0.0:
		finished.emit(WALKING,{"direction":direction})
