class_name Gun
extends Area2D

const BULLET = preload("res://scenes/dendalion/bullet.tscn")

func _ready():
	pass

func _process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	$%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout():
	shoot()
