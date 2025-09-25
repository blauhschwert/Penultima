class_name JadePlyer
extends CharacterBody2D

signal health_depleted

enum State {RESET, IDLE, WALK, ATTACK, DASH}
var _state : State = State.RESET

var health = 100.0 

@onready var _anim_player : AnimationPlayer = $Jademanition/AnimationPlayer
@onready var _jademani : Jademanition = %Jademanition

var _direction = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		set_jade_state(State.ATTACK)
		print(_state)
   
func _ready():
	_anim_player.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right",
		"move_up","move_down")
	velocity = direction * 135
	move_and_slide()
	
	_direction = direction

	if velocity.length() > 0.0:
		$Jademanition.play_walk_animation(direction)
	else:
		%Jademanition.play_idle_animation()
		
	const DAMAGE_RATE = 15.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func set_jade_state(p_state : State = State.RESET) -> void:
	if _state == p_state:
		return
	_state = p_state
	match _state:
		State.RESET:
			_jademani.toggle_jade_movement(true)
			_anim_player.play("idle")
		State.IDLE:
			$Jademanition.play_idle_animation()
		State.ATTACK:
			$Jademanition.play_attack_animation(_direction)

func _on_animation_finished(anim_name : String) -> void:
	match anim_name:
		"idle":
			pass
