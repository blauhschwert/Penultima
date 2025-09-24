class_name Jademanition
extends Node2D

@onready var _anim_player = %AnimationPlayer

func play_idle_animation() -> void:
	_anim_player.play("")
