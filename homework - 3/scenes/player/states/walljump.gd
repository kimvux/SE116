extends PlayerState

var normal
var push_timer

func _enter() -> void:
	#Change animation to jump
	obj.change_animation("jump")
	normal = obj.get_wall_normal()
	push_timer = 0.2
	pass

func _update(_delta: float):
	#Control moving
	push_timer -= _delta
	control_moving()
	obj.is_sliding = false
	obj.velocity.x += normal.x * 10
	obj.velocity.z += normal.z * 10
	#If velocity.y is less than 0 change to fall
	if push_timer < 0:
		change_state(fsm.states.fall)
	pass
