extends JadeState

const DENDILION = preload("res://scenes/characters/dendalion/dendalion.tscn")

var new_dendalion : Dendelion

func enter(_previous_state_path: String, _data := {}) -> void:
	jade.attack_timer.timeout.connect(_use_dendilion)
	new_dendalion = DENDILION.instantiate()
	add_child(new_dendalion)
	

func physics_update(_delta: float) -> void:
	var enemies_in_range = jade.dendilionArea.get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		new_dendalion.look_at(target_enemy.global_position)


func exit() -> void:
	jade.attack_timer.timeout.disconnect(_use_dendilion)

func _use_dendilion():
	pass
