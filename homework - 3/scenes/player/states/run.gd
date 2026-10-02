extends PlayerState

func _enter() -> void:
	#Change animation to run
	obj.change_animation("run")
	pass

func _update(delta: float):
	#Control jump
	if control_jump():
		return
	#Control moving and if not moving change to idle
	if !control_moving():
		change_state(fsm.states.idle)
	#If not on floor change to fall
	if !obj.is_on_floor():
		change_state(fsm.states.fall)
	pass
