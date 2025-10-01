class_name UIControler
extends CanvasLayer

signal switchWeapon(weapon:String)

@onready var controll_sprite: Sprite2D = %ControllSprite
@onready var action_button = $UIControler/Joystick/A_Button

const dendalion_text : Texture2D = preload("res://assets/Button/F3.png")
const dendalion_sword : Texture2D = preload("res://assets/Button/F0.png")

var attack_type : String = "Dendalion"

func _ready() -> void:
	$UIControler/Joystick/A_Button.texture_normal = dendalion_text
	pass


func _on_a_button_pressed() -> void:
	if attack_type == "Dendalion":
		attack_type = "Sword"
		$UIControler/Joystick/A_Button.texture_normal = dendalion_sword
		switchWeapon.emit(attack_type)
	elif attack_type == "Sword":
		attack_type = "Dendalion"
		$UIControler/Joystick/A_Button.texture_normal = dendalion_text
		switchWeapon.emit(attack_type)
	
