class_name ScoreBonus
extends Sprite2D

@onready var score_bonus_label = $Label

var score_bonus : String = ""

func _ready() -> void:
	$Label.text = score_bonus
	
func _process(_delta: float) -> void:
	$Label.text = score_bonus
	
func change_bonus_score(_p_score_bonus : String):
	score_bonus = CounterMobs.global_score.pop_front()
	$AnimationPlayer.play("ScoreBonus/add_score")
