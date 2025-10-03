class_name GameUI
extends CanvasLayer

@onready var score_label = $Control/Label
@onready var score_bonus : ScoreBonus = $ScoreBonus

var delta_score = 0

func _ready() -> void:
	score_label.text = "Score : " + str(MobCounter.surpassed_enemys)


func _process(_delta: float) -> void:
	score_label.text = "Score : " + str(MobCounter.surpassed_enemys)
