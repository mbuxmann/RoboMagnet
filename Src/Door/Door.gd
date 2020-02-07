extends Area2D

export (String) var next_level = "res://Src/Levels/Level02.tscn"

onready var anim_player: AnimationPlayer = get_node("Skin/AnimationPlayer")
onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var audio_player: AudioStreamPlayer = get_node("Sounds/AudioStreamPlayer")
onready var timer: = get_node("Timer")
onready var batteries_required = get_node("../../Batteries").get_child_count()

func _ready() -> void:
	anim_player.play("Door_Closed_Idle")
	collision_shape.disabled = true
	
func check(batteries) -> void:
	if batteries == batteries_required:
		timer.start()
		anim_player.play("Door_Opening")
	
func _on_Door_body_entered(body: Node) -> void:
	if body.name == "Player":
		Autoload.current_level = next_level
		get_tree().change_scene(next_level)

func _on_Timer_timeout() -> void:
	audio_player.play()
	
