class_name Jademanition
extends Node2D

@onready var _anim_player = %AnimationPlayer
@onready var _jade_movement = $Jade_Atlas
@onready var _jade_skills = $JadeSkills

func _ready():
	_jade_movement.visible = false
	_jade_skills.visible = false

func play_idle_animation() -> void:
	_anim_player.play("idle")

func play_walk_animation(p_vector : Vector2 ) -> void:
	_jade_movement.visible = true
	match p_vector:
		Vector2(1,0):
			_anim_player.play("walk_left")
		Vector2(-1,0):
			_anim_player.play("walk_right")
		Vector2(0,-1):
			_anim_player.play("walk_up")
		Vector2(0,1):
			_anim_player.play("walk_down")
		Vector2.ZERO:
			_anim_player.play("idle")
		_:
			_anim_player.play("idle")

func play_shoot_animation(p_vector : Vector2 ) -> void:
	match p_vector:
		Vector2(1,0):
			_anim_player.play("shooting_right")
		Vector2(-1,0):
			_anim_player.play("shooting_left")
		Vector2(0,-1):
			_anim_player.play("shooting_UP")
		Vector2(0,1):
			_anim_player.play("shooting_down")

func play_attack_animation(p_vector : Vector2 ) -> void:
	match p_vector:
		Vector2(1,0):
			_anim_player.play("shooting_right")
		Vector2(-1,0):
			_anim_player.play("shooting_left")
		Vector2(0,-1):
			_anim_player.play("shooting_UP")
		Vector2(0,1):
			_anim_player.play("shooting_down")

@warning_ignore("unused_parameter")
func toggle_jade_movement(p_bool : bool) -> void:
	_jade_skills.visible = false
	_jade_movement.visible = not _jade_movement.visible

@warning_ignore("unused_parameter")
func toggle_jade_skills(p_bool : bool) -> void:
	_jade_movement.visible = false
	_jade_skills.visible = not _jade_skills.visible
