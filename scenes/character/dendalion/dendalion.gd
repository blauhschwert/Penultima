class_name Dendelion
extends Area2D

const BULLET = preload("res://scenes/character/dendalion/bullet.tscn")

var attack_buffs
var _enabled : bool = true

@export var enabled:bool:
	get:
		return _enabled
	set(value):
		_enabled = value
		visible = value


func _ready():
	$%AttackBuff.timeout.connect(_reset_dendalion)
	%ShootingTimer.timeout.connect(_on_timer_timeout)
	%ShootingTimer.wait_time = 0.3
	enable_dendalion(true)

func _process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func enable_dendalion(p_bool : bool) -> void:
	set_process(p_bool)
	_enabled = p_bool

func change_bullet_spell(attack_buff) -> Bullet:
	var new_bullet
	if attack_buff != null:
		new_bullet = Bullet.new(attack_buff[0],attack_buff[1]) 
		#print(attack_buff) #[0, 2, 5.0, 0.15]
	
		%AttackBuff.wait_time = attack_buff[2]
		%AttackBuff.start()
		%ShootingTimer.wait_time = attack_buff[3]
		return new_bullet
	else:
		new_bullet = BULLET.instantiate()
		return new_bullet

func shoot():
	var new_bullet
	if not %AttackBuff.paused:
		new_bullet = change_bullet_spell(attack_buffs)
		new_bullet = BULLET.instantiate()
	else:
		new_bullet = BULLET.instantiate()
	
	new_bullet.global_transform = %ShootingPoint.global_transform
	$%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout():
	if has_overlapping_bodies():
		shoot()
	
func _reset_dendalion() -> void:
	%AttackBuff.stop()
	%ShootingTimer.wait_time = 0.3
