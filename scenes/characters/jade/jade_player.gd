class_name JadePlayer
extends CharacterBody2D

signal health_depleted

@export_enum("Sword","Dendalion") var weapon_class : int

const DENDALION = preload("res://scenes/characters/dendalion/dendalion.tscn")
const SLASH = preload("res://scenes/characters/attacks/slash/slash.tscn")

@export var speed := 350

var health = 100.0
var attack_buff = []


@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var slash_timer : Timer = $SlashTimer
@onready var hurtbox : Area2D = %HurtBox
@onready var _dendalion : Dendelion = $DendalionGun 

@onready var jade_progressbar : ProgressBar = %ProgressBar
@onready var _slash : Slash = $Slash

   
func _ready():
	slash_timer.timeout.connect(_create_slash)
	slash_timer.paused = true
	

func _physics_process(_delta):
	const DAMAGE_RATE = 15.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		jade_progressbar.value = health
		if health <= 0.0:
			health_depleted.emit()

func set_attack_buff(p_array : Array) -> void:
	attack_buff = p_array

func set_jade_buff(p_array : Array) -> void:
	if _dendalion != null:
		_dendalion.change_bullet_spell(p_array)

func update_health(amount : float) -> void:
	health += amount
	%ProgressBar.value = health

func _create_slash() -> void:
	var new_slash = SLASH.instantiate() 
	add_child(new_slash)
	_slash = new_slash


func _on_mobile_control_switch_weapon(weapon: String) -> void:
	print(weapon)
	match weapon:
		"Sword":
			# Free old weapon
			_dendalion.enable_dendalion(false)
			_dendalion.queue_free()
			slash_timer.paused = false
			
			slash_timer.start(1.05)
			
		"Dendalion":
			slash_timer.stop()
			
			var new_dendalion = DENDALION.instantiate()
			_dendalion = new_dendalion
			new_dendalion.enable_dendalion(true)
			add_child(new_dendalion)


func _on_slash_timer_timeout() -> void:
	_create_slash()
