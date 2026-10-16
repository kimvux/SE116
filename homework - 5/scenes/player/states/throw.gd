extends PlayerState

## The throw pose.

func _enter() -> void:
	#Switch the animation to "throw", stop horizontal movement, set the timer to 0.25 seconds
	#Doesn't touch the object — it already left the hand in Carry._update()
	obj.change_animation("throw")
	obj.stop_horizontal()
	timer = 0.25


func _update(_delta: float) -> void:
	#When the timer runs out, return to Idle
	if update_timer(_delta):
		change_state(fsm.states.idle)
