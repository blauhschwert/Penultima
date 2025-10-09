class_name CounterMobs
extends Node


static var surpassed_enemys := 0
static var global_score = []
static var score_bonus = [5,10,25]

static func add_counter() -> void:
	surpassed_enemys += 1
	create_score_bonus()

static func create_score_bonus() -> void:
	randomize()
	global_score.append([randi() % score_bonus.size()])
