extends Position2D
class_name Magnet

onready var sound: = $Sounds/AudioStreamPlayer
onready var raycast: = $Skin/RayCast2D
onready var Player: = get_parent()

var magnet_down = preload("res://Assets/Sounds/Magnet_SwitchDirection_Down.wav")
var magnet_up = preload("res://Assets/Sounds/Magnet_SwitchDirection_Up.wav")
var magnet_left = preload("res://Assets/Sounds/Magnet_SwitchDirection_Left.wav")
var magnet_right = preload("res://Assets/Sounds/Magnet_SwitchDirection_Right.wav")

# warning-ignore:unused_argument
func _process(delta: float) -> void:
	set_magnet_direction()
	set_magnet_animation()
	play_magnet_sound()
	if raycast.is_colliding() and Input.is_action_pressed("magnet_activate"):
		Player.magnetized = true
		Player.magnetized_to = raycast.get_collider().magnet_direction
		Player.magnet_duration = raycast.get_collider().magnet_duration
	else:
		Player.magnetized = false
	
	
func set_magnet_direction() -> void:
	if Input.is_action_pressed("magnet_right"):
		rotation_degrees = 0
		get_node("Skin").position = Vector2(17, 0)
	if Input.is_action_pressed("magnet_left"):
		rotation_degrees = 180
		get_node("Skin").position = Vector2(17, 0)
	if Input.is_action_pressed("magnet_up"):
		rotation_degrees = -90
		get_node("Skin").position = Vector2(24, 0)
	if Input.is_action_pressed("magnet_down"):
		rotation_degrees = 90
		get_node("Skin").position = Vector2(-24, 0)

func set_magnet_animation() -> void:
	if Input.is_key_pressed(32):
		get_node("Skin/AnimationPlayer").play("Magnet_Active")
	else:
		get_node("Skin/AnimationPlayer").play("Magnet_Idle")

func play_magnet_sound() -> void:
	if !sound.playing:
			if Input.is_action_pressed("magnet_right") and sound.stream != magnet_right:
				sound.stream = magnet_right
				sound.play()
			if Input.is_action_pressed("magnet_left") and sound.stream != magnet_left:
				sound.stream = magnet_left
				sound.play()
			if Input.is_action_pressed("magnet_up") and sound.stream != magnet_up:
				sound.stream = magnet_up
				sound.play()
			if Input.is_action_pressed("magnet_down") and sound.stream != magnet_down:
				sound.stream = magnet_left
				sound.play()
