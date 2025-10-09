class_name VirtuelJoystick
extends Node2D

signal sendVector(pos:Vector2)

var posVector : Vector2

func _process(delta: float) -> void:
	sendVector.emit(posVector)
