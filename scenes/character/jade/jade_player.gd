class_name JadePlayer
extends CharacterBody2D

signal health_depleted

@export_enum("Sword","Dendalion") var weapon_class : int

const DENDALION = preload("res://scenes/character/dendalion/dendalion.tscn")
const SLASH = preload("res://scenes/character/attacks/slash/slash.tscn")

@export var speed := 175

var health = 100.0
var attack_buff = []
var direction := Vector2.ZERO

var nearest_enemy : Enemy
var nearest_enemy_distance : float = INF

var XP : int = 0:
	set(value):
		XP = value
		$%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "LVL : " + str(value)
		#%Options.show_option()
		
		
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var hurtbox : Area2D = %HurtBox

@onready var jade_progressbar : ProgressBar = %ProgressBar
@onready var ui_controller =  get_node("/root/MainGame/MobileControl")

   
func _ready():
	$UI/Weapons/Slots.focused_style_box()
	ui_controller.switchWeapon.connect(_on_mobile_control_switch_weapon)
	

func _physics_process(_delta):
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
		#print(nearest_enemy.name)
	else:
		nearest_enemy_distance = INF
	
	jade_damage(_delta)
	check_XP()


func _on_mobile_control_switch_weapon(weapon: String) -> void:
	match weapon:
		"Sword":
			$UI/Weapons/Slots.unfocused_style_box()
			$UI/Weapons/Slots2.focused_style_box()
			
		"Dendalion":
			print(weapon)
			$UI/Weapons/Slots2.unfocused_style_box()
			$UI/Weapons/Slots.focused_style_box()


func jade_damage(_delta) -> void:
	const DAMAGE_RATE = 15.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		jade_progressbar.value = health
		if health <= 0.0:
			health_depleted.emit()

func update_health(amount : float) -> void:
	health += amount
	%ProgressBar.value = health

func gain_XP(amount):
	XP += amount
	total_XP += amount

func check_XP():
	if XP > %XP.max_value:
		XP -= $%XP.max_value
		level += 1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
