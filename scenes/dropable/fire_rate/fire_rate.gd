class_name AttackBuff
extends Node2D

@export var attack_stats : AttackStats 

func _ready() -> void:
	pass

func create_attack_dic() -> Dictionary:
	var newDic = {
		"attack_type" : attack_stats.attack_class,
		"attack" : attack_stats.damage,
		"durability" : attack_stats.durabilty,
		"shoot_rate" : attack_stats.shoot_rate
	}
	return newDic
