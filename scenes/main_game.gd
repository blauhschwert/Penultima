class_name MainGame
extends Node2D

const healing_pot = preload("res://scenes/dropable/heal/HealingPotion.tscn")
const MAX_MOBS = 31


var healing_spots = []
var cur_heal_potion
var cur_heal_dic
var mob_count = 0


@onready var jade_player : JadePlayer = $Player

func _ready() -> void:
	mob_count = 0
	randomize()
	$Timer.connect("timeout",_on_timer_timeout)
	for e in $Spots.get_children():
		healing_spots.append(e)
	create_healing()
	$AudioStreamPlayer2D.play()
	%GameOver.visible = false
	
	$MobileControl.sended_dir.connect(_send_vector)

func _process(_delta: float) -> void:
	pass

func spawn_mob():
	if mob_count >= MAX_MOBS:
		return
		
	var new_mob = preload("res://scenes/enemys/weasel/weasel_enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	mob_count += 1
	new_mob.tree_exited.connect(_on_mob_tree_exited)
	

func create_healing():
	var heal_pot = healing_pot.instantiate()
	heal_pot.global_position = healing_spots[randi() % healing_spots.size()].global_position
	cur_heal_potion = heal_pot
	add_child(cur_heal_potion)



func _on_timer_timeout():
	spawn_mob()

func _reload_game() -> void:
	get_tree().reload_current_scene()
	CounterMobs.surpassed_enemys = 0
	for n in get_node("AttackBuffs").get_children():
		n.queue_free()
	if $%GameOver.visible:
		%GameOver.visible = false 

## Hide some objects and pauses the game if the player lose its health
func _on_player_health_depleted() -> void:
	set_process(false)
	$GameUI.visible = false
	%GameOver.visible = true
	$AudioStreamPlayer2D.stop()
	await get_tree().create_timer(3).timeout
	$GameOver/ColorRect/Label2.visible = true
	$GameOver/ColorRect/Label2.text = "Score :" + str(CounterMobs.surpassed_enemys)

func _send_vector(posVec : Vector2) -> void:
	jade_player.direction = posVec

func _on_mob_tree_exited() -> void:
	mob_count -= 1
