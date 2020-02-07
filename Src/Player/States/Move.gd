extends State

"""
Parent State that abstracts and handles basic movement
"""

export var max_speed_default: = Vector2(200.0, 900.0)
export var acceleration_default: = Vector2(1000.0, 2000.0)
export var deccelaration_default: = Vector2(1000.0, 3000.0)
export var max_speed_fall: = 1500.0

onready var Player = get_node("../../")

var acceleration: = acceleration_default
var decceleration: = deccelaration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO
var facing: = Vector2(1, 1)
var old_max_speed_fall = max_speed_fall

# Sounds
var hover_initial = preload("res://Assets/Sounds/Robot_Hover_Initial.wav")
var hover_loop = preload("res://Assets/Sounds/Robot_Hover_Loop.wav")
var robot_idle = preload("res://Assets/Sounds/Robot_Idle_Loop.wav")
var robot_land = preload("res://Assets/Sounds/Robot_LandFromFall.wav")

func physics_process(delta: float) -> void:
	if owner.magnetized:
		owner.move_and_collide(owner.magnetized_to)   
		velocity.y = 0
		acceleration.y = 0
		$magnet_duration.wait_time = owner.magnet_duration   
		$magnet_duration.start()
	velocity = calculate_velocity(velocity, max_speed, acceleration, decceleration, delta, get_move_direction(), max_speed_fall)
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	set_animation()
	
func enter(msg: Dictionary = {}) -> void:
	pass
		
func exit() -> void:
	pass
	
static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		decceleration: Vector2,
		delta: float,
		move_direction: Vector2,
		max_speed_fall: = 1500.0
	) -> Vector2:
	var new_velocity: = old_velocity
	
	new_velocity.y += move_direction.y * acceleration.y * delta
	
	if move_direction.x:
		new_velocity.x += move_direction.x * acceleration.x * delta
	elif abs(new_velocity.x) > 0.1:
		new_velocity.x -= decceleration.x * delta * sign(new_velocity.x)
		new_velocity.x = new_velocity.x if sign(new_velocity.x) == sign(old_velocity.x) else 0
		
	new_velocity.x = clamp(new_velocity.x, -max_speed	.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed_fall)
	
	return new_velocity
	
static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)

func set_animation() -> void:
	if velocity.x == 0:
		owner.get_node('Skin/AnimationPlayer').play('Player_Idle')
		owner.get_node('Skin/Sprite').scale = facing
		if owner.audio_player.stream != robot_idle:
			owner.audio_player.stream = robot_idle
			owner.audio_player.play()
	
	
	elif abs(velocity.x) > 0 and !owner.magnetized:
		owner.get_node('Skin/AnimationPlayer').play('Player_Move')
		if owner.audio_player.stream != hover_loop:
			owner.audio_player.stream = hover_loop
			owner.audio_player.play()
			
		if velocity.x > 0:
			owner.get_node('Skin/Sprite').scale = Vector2(1, 1)
			facing = owner.get_node('Skin/Sprite').scale
		elif velocity.x < 1:
			owner.get_node('Skin/Sprite').scale = Vector2(-1, 1)
			facing = owner.get_node('Skin/Sprite').scale


func _on_Timer_timeout() -> void:
	acceleration.y = 3000.0
