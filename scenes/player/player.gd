class_name Player
extends CharacterBody2D

enum States {NONE, MOVE, JUMP, ATTACK}

@export var max_speed = 15.0
@export var acceleration = 1000.0
@export var air_accelertation = 2000.0
@export var friction = 1000.0
@export var air_friction = 500.0
@export var up_gravity = 500.0
@export var down_gravity = 600.0
@export var jump_amount = 200.0

var state : States = States.NONE
var coyote_time = 0.0

@onready var anim_player : AnimationPlayer = $AnimationPlayer

var lambda_test = func(x):
	print(x)

func _ready():
	
	lambda_test.call("do you see what we see ???")

func _input(event):
	var x_input = Input.get_axis("left","right")
	if x_input != 0.0:
		state = States.MOVE
	elif Input.is_action_just_pressed("attack"):
		state = States.ATTACK
	else:
		state = States.NONE

func _physics_process(delta) -> void:
	apply_gravity(delta)
	coyote_time -= delta
	
	match state:
		States.NONE:
			anim_player.pause()
		States.MOVE:
			anim_player.play("walk")
			player_move(delta)
		States.ATTACK:
			pass
			

func player_move(delta) -> void:
	var x_input = Input.get_axis("left","right")
	apply_gravity(delta)
	if x_input != 0.0:
		accelerate_horizontally(x_input,delta)
	else:
		apply_friction(delta)
	
	if x_input <= 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	var was_on_floor: = is_on_floor()
	move_and_slide()
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_time += 0.2

func player_attack(dir : Vector2) -> void:
	if dir == Vector2(1,0):
		anim_player.play("attack")
	elif dir == Vector2(-1,0):
		anim_player.play("attack_right")
	else:
		print("Error wrong vector")


func accelerate_horizontally(horizontal_dir: float, delta : float) -> void:
	var accelation_amount = acceleration
	if not is_on_floor(): accelation_amount = air_accelertation
	velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, 
							 accelation_amount * delta * abs(horizontal_dir))
	
func apply_friction(delta) -> void:
	var fricton_amount = friction
	if not is_on_floor(): fricton_amount = air_friction
	velocity.x = move_toward(velocity.x, 0.0, fricton_amount * delta)

func apply_gravity(delta) -> void:
	if not is_on_floor():
		if velocity.y <= 0:
			velocity.y += up_gravity * delta
		else:
			velocity.y += down_gravity * delta


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		state = States.NONE
