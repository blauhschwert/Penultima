class_name GameUI
extends CanvasLayer

@onready var score_label = $Control/Label
@onready var score_bonus : ScoreBonus = $ScoreBonus

var bonus_score := str(5)

func _ready() -> void:
	score_label.text = "Score : " + str(MobCounter.mob_counter)
	MobCounter.change_score.connect(_change_score_bonus)

func _process(_delta: float) -> void:
	score_label.text = "Score : " + str(MobCounter.mob_counter)
	var delta_mob = CounterMobs.mob_counter
	if delta_mob > CounterMobs.mob_counter :
		_change_score_bonus()

func _change_score_bonus():
	score_bonus.change_bonus_score(bonus_score)
