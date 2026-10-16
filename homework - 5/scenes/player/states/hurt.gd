extends PlayerState

const KNOCKBACK_SPEED := 8.0
const HOP_SPEED:= 5.0
func _enter() -> void:
	#Switch the animation to "hurt"
	#Turn on obj.is_invulnerable so one hit doesn't drain health every frame in a row
	#Push the character back in the XZ plane and hop it up slightly along the Y axis
	#Set the timer to 0.5 seconds
	obj.change_animation("hurt")
	timer = 0.5
	obj.is_invulnerable = true
	var push: Vector3 = -obj.forward() * KNOCKBACK_SPEED
	obj.velocity.x = push.x
	obj.velocity.z = push.z
	obj.velocity.y = HOP_SPEED
	pass


func _exit() -> void:
	#Turn off obj.is_invulnerable
	obj.is_invulnerable = false
	pass


func _update(_delta: float) -> void:
	if update_timer(_delta):
		change_state(fsm.states.idle)
	#When the timer runs out, return to Idle. Meanwhile do NOT call control_moving()/control_jump()
	#— can't be controlled while stunned
	pass
