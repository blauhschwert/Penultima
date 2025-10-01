class_name MainGame
extends Node2D

const healing_pot = preload("res://scenes/dropable/heal/HealingPotion.tscn")

var healing_spots = []
var cur_heal_potion
var cur_heal_dic

func _ready() -> void:
	randomize()
	$Timer.connect("timeout",_on_timer_timeout)
	for e in $Spots.get_children():
		healing_spots.append(e)
	create_healing()
	$AudioStreamPlayer2D.play()
	

func _process(_delta: float) -> void:
	pass

func spawn_mob():
	var new_mob = preload("res://scenes/enemys/weasel/weasel_enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func create_healing():
	var heal_pot = healing_pot.instantiate()
	heal_pot.global_position = healing_spots[randi() % healing_spots.size()].global_position
	cur_heal_potion = heal_pot
	add_child(cur_heal_potion)

func _spawn_healing() -> void:
	var new_spot = healing_pot[randi() % healing_pot.size()]
	if CounterMobs.mob_counter % 3 == 0:
		#new_spot.global_position  
		pass

func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
