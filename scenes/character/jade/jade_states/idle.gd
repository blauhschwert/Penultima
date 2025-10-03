extends JadeState

func enter(_previous_state_path: String, _data := {}) -> void:
	jade_hurtbox = jade.hurtbox
	jade_player = jade.anim_player
	jade_player.play("IDLE")


func handle_input(_event: InputEvent) -> void:
	jade.direction = Input.get_vector("move_left","move_right","move_up","move_down")


func physics_update(_delta: float) -> void:
	jade.velocity = jade.direction * jade.speed
	jade.move_and_slide()
	
	if jade.velocity.length() > 0.0:
		finished.emit(WALKING,{"direction":jade.direction})
