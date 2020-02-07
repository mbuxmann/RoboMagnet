extends State

onready var move: = get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)
	print('test')
	
func physics_process(delta: float) -> void:	
	print('test')

func enter(msg: Dictionary = {}) -> void:
	pass
	
func exit() -> void:
	pass
