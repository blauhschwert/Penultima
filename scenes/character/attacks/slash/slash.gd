class_name Slash
extends Area2D

signal slashFinished

@export var damage := 2
@export var life_time : float = 1.25

@onready var _anim_player = $AnimationPlayer

var intersect_mobs : Array = []
var _enabled : bool = false

@export var enabled:bool:
	get:
		return _enabled
	set(value):
		_enabled = value
		visible = value


func _ready() -> void:
	_anim_player.play("slash")

func endable_slash(p_bool : bool) -> void:
	set_process(p_bool)
	_enabled = p_bool

func _on_body_entered(_body: Node2D) -> void:
	if has_overlapping_bodies():
		intersect_mobs = get_overlapping_bodies()
		for e in intersect_mobs:
			if e.has_method("take_damage"):
				e.take_damage(damage)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		slashFinished.emit()
		queue_free()
