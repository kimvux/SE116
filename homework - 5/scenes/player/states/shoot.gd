extends PlayerState

## Shoot a bullet like the barrel: stand still, fire after a short delay, then go back to Idle.

@export var shoot_delay: float = 0.1

var _fire_timer: float = 0
var _has_fired: bool = false


func _enter() -> void:
	obj.change_animation("throw")
	obj.stop_horizontal()
	_has_fired = false
	_fire_timer = shoot_delay
	timer = 0.3


func _update(_delta: float) -> void:
	if not _has_fired:
		_fire_timer -= _delta
		if _fire_timer <= 0:
			obj.fire()
			_has_fired = true
	if update_timer(_delta):
		change_state(fsm.states.idle)
