class_name PlayerState
extends FSMState

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(delta: float) -> void:
	pass

#Control moving and changing state to run
#Return true if moving
func control_moving() -> bool:
	var input: Vector2 = Input.get_vector("left", "right", "up", "down")
	var is_moving: bool = input.length() > 0.1
	if is_moving:
		obj.change_direction(BaseCharacter.direction_from_input(input))
		obj.velocity.x = obj.movement_speed * input.x
		obj.velocity.z = obj.movement_speed * input.y
		obj.anim_player.set_speed_scale(1)
		if (Input.is_action_pressed("run")):
			obj.velocity.x *= obj.run_multiply
			obj.velocity.z *= obj.run_multiply
			obj.anim_player.set_speed_scale(obj.run_multiply)
		if obj.is_on_floor():
			change_state(fsm.states.run)
		return true
	else:
		obj.stop_horizontal()
	return false

#Control jumping
#Return true if jumping
func control_jump() -> bool:
	#If jump is pressed change to jump state and return true
	if Input.is_action_just_pressed("jump") and obj.jump_remain > 0:
		obj.jump()
		if obj.is_sliding:
			change_state(fsm.states.walljump)
		else:
			change_state(fsm.states.jump)
		return true
	return false
