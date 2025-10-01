class_name PixelTree
extends StaticBody2D


var tree_00 = preload("res://assets/Tree00.png")
var tree_01 = preload("res://assets/Tree01.png")
var tree_02 = preload("res://assets/Tree02.png")


func _ready() -> void:
	randomize()
	_change_random_texture()

func _change_random_texture() -> void:
	var textures = [tree_00,tree_01,tree_02]
	var random_texture = textures[randi() % textures.size()]
	$Tree.texture = random_texture
