class_name UIControler
extends CanvasLayer

signal switchWeapon(weapon:String)
signal sended_dir(pos:Vector2)

@onready var action_button = $UIControler/Joystick/A_Button
@onready var joystick : VirtuelJoystick = $UIControler/Joystick/VirtuelJoystick


const dendalion_text : Texture2D = preload("res://assets/Button/F3.png")
const dendalion_sword : Texture2D = preload("res://assets/Button/F0.png")

var attack_type : String = "Dendalion"


func _ready() -> void:
	$UIControler/Joystick/A_Button.texture_normal = dendalion_text
	

func _process(_delta: float) -> void:
	sended_dir.emit(joystick.posVector)

func _on_a_button_pressed() -> void:
	if attack_type == "Dendalion":
		attack_type = "Sword"
		$UIControler/Joystick/A_Button.texture_normal = dendalion_sword
		switchWeapon.emit(attack_type)
	elif attack_type == "Sword":
		attack_type = "Dendalion"
		$UIControler/Joystick/A_Button.texture_normal = dendalion_text
		switchWeapon.emit(attack_type)
	
