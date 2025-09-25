class_name Weaselmation
extends Node2D

func play_walk(p_vector):
	match p_vector:
		Vector2(-1.0,0):
			%AnimationPlayer.play("walk_left")
		Vector2(1.0,0):
			%AnimationPlayer.play("walk_right")
		Vector2(0,1.0):
			%AnimationPlayer.play("walk_down")
		Vector2(0,-1.0):
			%AnimationPlayer.play("walk_up")

func play_hurt():
	%AnimationPlayer.play("hurt")
