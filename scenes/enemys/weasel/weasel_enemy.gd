class_name WeaselEnemy
extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/MainGame/Player")

var _direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	_direction = direction
	velocity = direction * 45.0
	move_and_slide()

func take_damage(amount):
	health -= amount
	%Weaselwalk.play_hurt()
	
	if health <= 0:
		const SMOKE_SCENE = preload("res://scenes/enemys/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		CounterMobs.add_counter()
		
		const DROPABLE_SCENE = preload("res://scenes/dropable/dropable.tscn")
		var rare_drop = DROPABLE_SCENE.instantiate()
		rare_drop.drop_reward(global_position)
		get_tree().get_root().add_child.call_deferred(rare_drop)
		
		queue_free()
