class_name HealingPotion
extends Area2D

signal update_health(new_health)

@export var healing_dic : Dictionary = {
	"healing_amount" : 0,
	"healing_interval" : 0.0
}

func _ready() -> void:
	$healingInterval.wait_time = healing_dic["healing_interval"]


func _drop_healing() -> void:
	MobCounter.dropHeal.emit(healing_dic)
	print(healing_dic)

func healing(old_health : int) -> float:
	return old_health + healing_dic[0]
	
func _on_healing_interval_timeout() -> void:
	update_health.emit(healing_dic["healing_amount"] / 3)


func _on_body_entered(body: Node2D) -> void:
	if body is JadePlayer:
		body.update_health(healing_dic["healing_amount"])
		queue_free()
