extends JadeState

var jade_dir := Vector2.ZERO

## If state is created or used : 
## - finished.emit(WALKING,{"direction":direction})
## - { "direction": (0.0, -1.0) }
func enter(_previous_state_path: String, _data := {}) -> void:
	jade_player = jade.anim_player

func handle_input(_event: InputEvent) -> void:
	jade_dir = Input.get_vector("move_left","move_right","move_up","move_down")

func physics_update(_delta: float) -> void:
	jade.velocity = jade.direction * jade.speed
	jade.move_and_slide()
	
	if jade.velocity.length() > 0.0:
		get_match_direction()
	else:
		finished.emit(IDLE)

func get_match_direction() -> void:
	match jade.direction.floor():
		Vector2(1.0,0.0):
			jade_player.play("WALK_RIGHT")
		Vector2(-1.0,0.0):
			jade_player.play("WALK_LEFT")
		Vector2(0.0,-1.0):
			jade_player.play("WALK_UP")
		Vector2(0.0,1.0):
			jade_player.play("WALK_DOWN")
		_:
			jade_player.play("IDLE")
