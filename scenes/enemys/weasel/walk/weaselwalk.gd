class_name Weaselwalk
extends Node2D


func _ready() -> void:
	play_walk()

func play_walk():
	%AnimationPlayer.play("walk_down")

func play_hurt():
	$%AnimationPlayer.play("hurt")
