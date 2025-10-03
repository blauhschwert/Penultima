class_name Bullet
extends Area2D

var attack_type : int = 0
var attack_damage := 1
var travelled_distance = 0

func _init(p_att_type := 0, p_damage := 1) -> void:
	attack_type = p_att_type
	attack_damage = p_damage

func _physics_process(delta):
	const SPEED = 350
	const RANGE = 200
	
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
