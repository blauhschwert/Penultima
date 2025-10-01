class_name CounterMobs
extends Node

signal change_score

static var mob_counter := 0
static var global_score = []
static var score_bonus = [5,10,25]

func add_counter() -> void:
	mob_counter += 1
	change_score.emit()

static func create_score_bonus() -> void:
	randomize()
	global_score.append([randi() % score_bonus.size()])
