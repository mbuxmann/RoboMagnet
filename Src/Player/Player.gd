extends KinematicBody2D
class_name Player

const FLOOR_NORMAL: = Vector2.UP

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D
onready var Magnet: = $Magnet
onready var audio_player: AudioStreamPlayer = get_node("Sounds/AudioStreamPlayer")
onready var death_player: AudioStreamPlayer = get_node("Sounds/death")
onready var Door = get_node("../Door/Door")

var player_death = preload("res://Assets/Sounds/Robot_Death.wav")
var batteries: = 0
var player_died = false
var player_has_died = false
var magnetized = false
var magnetized_to = Vector2(0, 0)
var magnet_duration = null
func _process(delta: float) -> void:
	pass

func add_battery() -> void:
	batteries += 1
	check_door()
	
func check_door() -> void:
	Door.check(batteries)

func die() -> void:
	if !death_player.is_playing():
		death_player.play()
		audio_player.stop()
		state_machine.player_died = true
		player_died = true
		$Timer.start()


func _on_Timer_timeout() -> void:
	get_tree().change_scene(Autoload.current_level)
