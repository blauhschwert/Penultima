class_name MainGame
extends Node2D

func _ready() -> void:
	randomize()
	$Timer.connect("timeout",_on_timer_timeout)

func spawn_mob():
	var new_mob = preload("res://scenes/enemys/weasel/weasel_enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
