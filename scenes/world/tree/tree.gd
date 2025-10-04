class_name PixelTree
extends StaticBody2D


var tree_00 = preload("res://assets/tree00.png")
var tree_01 = preload("res://assets/tree01.png")
var tree_02 = preload("res://assets/tree02.png")
var tree_03 = preload("res://assets/tree03.png")


func _ready() -> void:
	randomize()
	_change_random_texture()

func _change_random_texture() -> void:
	var textures = [tree_00,tree_01,tree_02]
	var random_texture = textures[randi() % textures.size()]
	$Tree.texture = random_texture
