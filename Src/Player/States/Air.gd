extends State

onready var move: = get_parent()

func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)
	
func physics_process(delta: float) -> void:
	move.physics_process(delta)
	
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		_state_machine.transition_to(target_state)
	

func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)

func exit() -> void:
	move.exit()
	
