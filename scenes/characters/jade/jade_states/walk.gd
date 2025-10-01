extends JadeState

var _dir := Vector2.ZERO

## If state is created or used : 
## - finished.emit(WALKING,{"direction":direction})
## - { "direction": (0.0, -1.0) }
func enter(_previous_state_path: String, _data := {}) -> void:
	jade_player = jade.anim_player

func handle_input(_event: InputEvent) -> void:
	_dir = Input.get_vector("move_left","move_right",
									 "move_up","move_down")


func physics_update(_delta: float) -> void:
	jade.velocity = _dir * jade.speed
	jade.move_and_slide()
	
	if jade.velocity.length() > 0.0:
		jade_player.play(get_match_direction())
	else:
		finished.emit(IDLE)

func get_match_direction() -> String:
	match _dir:
		Vector2(1.0,0):
			return "WALK_RIGHT"
		Vector2(-1.0,0):
			return "WALK_LEFT"
		Vector2(0,-1.0):
			return "WALK_UP"
		Vector2(0,1.0):
			return "WALK_DOWN"
		_:
			return "IDLE"
