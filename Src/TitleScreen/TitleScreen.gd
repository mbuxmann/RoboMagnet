extends Control

onready var sound_player = get_node("Sounds/AudioStreamPlayer")
onready var timer = get_node("Timer")

var play_button = preload("res://Assets/Sounds/UI Menu Select Button1.wav")
var exit_button = preload("res://Assets/Sounds/UI Menu Select Button2.wav")
var start_game = false

func _ready() -> void:
	get_node("Player/Skin/AnimationPlayer").play("Player_Idle")
	get_node("Enemy/Skin/AnimationPlayer").play("Enemy_Idle")


func _on_Play_pressed() -> void:
	start_game = true
	sound_player.stream = play_button
	sound_player.play()
	timer.start()


func _on_Exit_pressed() -> void:
	sound_player.stream = exit_button
	sound_player.play()
	timer.start()

func _on_Timer_timeout() -> void:
	if start_game:
		get_tree().change_scene("res://Src/Levels/Level01.tscn")
	else:
		get_tree().quit()
		
