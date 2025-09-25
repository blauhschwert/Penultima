class_name WeaselEnemy
extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/MainGame/Player")

var _direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(_delta):
	%Weaselmation.play_walk(_direction)
	var direction = global_position.direction_to(player.global_position)
	_direction = direction
	velocity = direction * 85.0
	move_and_slide()

func take_damage():
	health -= 1
	%Weaselmation.play_hurt()
	
	if health == 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://scenes/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
