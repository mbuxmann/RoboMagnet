extends Area2D

onready var anim_player: AnimationPlayer = get_node("Skin/AnimationPlayer")
onready var audio_player: AudioStreamPlayer = get_node("Sounds/AudioStreamPlayer")

var body_has_entered = false

func _ready() -> void:
	anim_player.play("Battery_Idle")

func _on_Battery_body_entered(body: Node) -> void:
	if body.name == "Player" and !body_has_entered:
		body_has_entered = true
		body.add_battery()
		audio_player.play()
		anim_player.play("Battery_Pickedup")


func _on_AudioStreamPlayer_finished() -> void:
	queue_free()
