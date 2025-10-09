class_name Forrest
extends Node2D

var tree_folder = "res://assets/trees/"
var tree_assets = []

func _ready() -> void:
	randomize()

## 	read_tree_assets(tree_folder)
##  print(tree_assets)
##
func read_tree_assets(path : String) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if !file_name.begins_with(".") and !file_name.ends_with(".import"):
					print("Found file: " + file_name)
					tree_assets.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
