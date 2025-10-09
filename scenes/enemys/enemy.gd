class_name Enemy
extends CharacterBody2D

@export var player_reference : JadePlayer
var damage_popup_node = preload("res://scenes/UI/damage_label.tscn")
var _direction : Vector2
var _speed : float = 45
var damage : float
var knockback : Vector2
var separation : float

var drop = preload("res://scenes/dropable/PickUp.tscn")

var health : float:
	set(value):
		health = value
		if health <= 0:
			_spawn_smoke()
			_spawn_xp()
			queue_free()

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://scenes/enemys/Shaders/Rainbow/Rainbow.tres")
			scale = Vector2(1.25,1.25)
			health += 3

var type : EnemyType:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		health = value.health

func _physics_process(delta: float) -> void:
	check_separation(delta)
	knockback_update(delta)

func check_separation(_delta):
	separation = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
	
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * _speed
	knockback = knockback.move_toward(Vector2.ZERO,1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider is JadePlayer and Enemy:
		collider.get_collider().knockback = (collider.get_collider().global_position -
		global_position).normalized() * 50

func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount)
	popup.global_position = global_position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)

func take_damage(amount):
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"modulate",Color(3,0.25,0.25),0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1,1,1),0.2)
	tween.bind_node(self)
	
	damage_popup(amount)
	health -= amount

func _spawn_smoke() -> void:
		const SMOKE_SCENE = preload("res://scenes/enemys/Shaders/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		CounterMobs.add_counter()

func _spawn_buff():
	const DROPABLE_SCENE = preload("res://scenes/dropable/dropable.tscn")
	var rare_drop = DROPABLE_SCENE.instantiate()
	rare_drop.drop_reward(global_position)
	get_node("/root/MainGame/AttackBuffs").add_child.call_deferred(rare_drop)

func _spawn_xp():
	if type.drops.size() == 0:
		return
	
	var item = type.drops.pick_random()
	
	var item_to_drop = drop.instantiate()
	
	item_to_drop.type = item
	item_to_drop.position = position
	item_to_drop.player_reference = player_reference
	
	get_tree().current_scene.call_deferred("add_child",item_to_drop)
	
