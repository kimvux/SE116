extends PlayerState

func _enter() -> void:
	#Change animation to fall
	obj.change_animation("fall")
	pass

func _update(_delta: float) -> void:
	#Control moving
	var is_moving: bool = control_moving()
	#If on floor change to idle if not moving and not jumping
	if obj.is_on_wall():
		obj.jump_remain = 2
		if obj.is_sliding == false:
			obj.is_sliding = true
			obj.velocity.y = 0
	else:
		obj.is_sliding = false
	
	if obj.is_on_floor():
		obj.jump_remain = 2
		obj.is_sliding = false
		if !is_moving and !control_jump():
			change_state(fsm.states.idle)
	control_jump()
	pass
