class_name Dropable
extends Area2D

@export var reward_drop : AttackBuff

var attack_buffs = {
	"attack_type" : null,
	"attack" : 0,
	"durability" : 0.0,
	"shoot_rate" : 0.00
}

func _ready() -> void:
	pass

## Used for droping the right items in Coding type behaivor
func drop_reward(pos : Vector2) -> void:
	if GlobalDrops.pick_drop(GlobalDrops.drop_table) == "UncommonBuff":
		reward_drop.global_position = pos

func _create_attack_buff() -> Array:
	var array = [
		reward_drop.attack_stats.attack_class,
		reward_drop.attack_stats.damage,
		reward_drop.attack_stats.durabilty,
		reward_drop.attack_stats.shoot_rate
	]
	return array

func _on_body_entered(body: Node2D) -> void:
	var attack_stats = _create_attack_buff()
	if body is JadePlayer:
		body.set_jade_buff(attack_stats)
		
		queue_free()
		
