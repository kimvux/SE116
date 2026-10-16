extends PlayerState

## Currently carrying something overhead.

const LIFT_TIME := 0.18
const MOVE_SCALE := 0.6
const THROW_SPEED := 8.0
const THROW_UP_SPEED := 6.0

var _lift_tween: Tween = null


func _enter() -> void:
	#Call obj.held.be_picked_up(obj.hold_point): the object becomes a child of HoldPoint but stays
	#where it was
	#Tween the object's position to Vector3.ZERO over 0.18 seconds to lift it from the ground into
	#hand
	#While lifting, the fox stands still and ignores input
	obj.held.be_picked_up(obj.hold_point)
	obj.stop_horizontal()
	obj.change_animation("carry_idle")
	_lift_tween = obj.create_tween()
	_lift_tween.tween_property(obj.held, "position", Vector3.ZERO, LIFT_TIME)


func _exit() -> void:
	#Stop the lift tween if it's still running
	#If the hand is still full (got hit, died...), drop the object right where it is:
	#obj.held.be_dropped(obj.held.global_position), then obj.held = null
	if _lift_tween != null and _lift_tween.is_valid():
		_lift_tween.kill()
	_lift_tween = null
	if obj.held != null:
		obj.held.be_dropped(obj.held.global_position)
		obj.held = null


func _update(_delta: float) -> void:
	#Do nothing while still lifting
	#If "carry" is pressed -> obj.held.be_thrown(...), obj.held = null, then switch to state Throw
	#Otherwise move slower via move_by_input(0.6); change the animation to "carry" / "carry_idle"
	if _lift_tween != null and _lift_tween.is_running():
		return
	if Input.is_action_just_pressed("carry"):
		obj.held.be_thrown(obj.forward() * THROW_SPEED + Vector3.UP * THROW_UP_SPEED)
		obj.held = null
		change_state(fsm.states.throw)
		return
	if move_by_input(MOVE_SCALE):
		obj.change_animation("carry")
	else:
		obj.change_animation("carry_idle")
