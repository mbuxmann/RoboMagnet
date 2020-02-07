extends Node
class_name State, "res://Assets/Icons/state.svg"

"""
State interface to use in Hierachical State Machines.
"""

onready var _state_machine = _get_state_machine(self)

func unhandled_input(event: InputEvent) -> void:
	return
	
func physics_process(delta: float) -> void:
	return

func enter(msg: Dictionary = {}) -> void:
	return
	
func exit() -> void:
	return

func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

