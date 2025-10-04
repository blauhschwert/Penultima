extends JadeState

var _jade_dir := Vector2.ZERO

func enter(_previous_state_path: String, _data := {}) -> void:
	jade_hurtbox = jade.hurtbox
	jade_player = jade.anim_player
	jade_player.play("IDLE")


func handle_input(_event: InputEvent) -> void:
	_jade_dir = Input.get_vector("move_left","move_right","move_up","move_down")


func physics_update(_delta: float) -> void:
	if _jade_dir != Vector2.ZERO:
		jade.velocity = _jade_dir * jade.speed
	elif jade.direction.floor() != Vector2.ZERO:
		jade.velocity = jade.direction * jade.speed
		
	jade.move_and_slide()
	
	if _jade_dir != Vector2.ZERO:
		finished.emit(WALKING,{"dir":_jade_dir})
	elif jade.velocity.length() > 0.0:
		finished.emit(WALKING,{"dir":jade.direction})
