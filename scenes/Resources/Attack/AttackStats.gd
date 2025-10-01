class_name AttackStats
extends Resource

@export_category("Attack Modifiers")
@export_group("Attack")

@export_subgroup("Attack_forces")
@export var damage : int = 0
@export var durabilty : float = 0.00
@export var shoot_rate : float = 0.00

@export_subgroup("Attack_modifiers")
@export var attack_range : float = 0.00
#@export var max_pierce : int = 0	# thu goe beyond enemys
#@export var knockback_force : float = 0.00


@export_category("Attack Options")
@export_enum("Normal","Fire", "Ice", "Thunder") var attack_class : int
@export var attack_texture : Texture2D

func _get_attack_type() -> String:
	match attack_class:
		0:
			return "Normal"
		1:
			return "Fire"
		2:
			return "Ice"
		3:
			return "Thunder"
		_:
			return "Error" 

func hello_test() -> void:
	print("hdello")
