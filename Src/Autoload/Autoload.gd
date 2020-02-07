extends Node


var current_level = "res://Src/Levels/Level01.tscn"

func _ready() -> void:
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().change_scene(current_level)
	if Input.is_action_pressed("quit"):
		get_tree().change_scene("res://Src/TitleScreen/TitleScreen.tscn")
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
