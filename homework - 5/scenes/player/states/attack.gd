extends PlayerState

func _enter() -> void:
	#Switch the animation to "attack"
	#Stop horizontal movement
	#Set the timer to the animation's length
	#Enable the CollisionShape3D of Direction/HitArea3D
	obj.change_animation("attack")
	obj.stop_horizontal()
	timer = obj.anim_player.get_animation("attack_%s" % obj.direction).length
	_hit_shape().disabled = false
	pass


func _exit() -> void:
	#Disable the CollisionShape3D of Direction/HitArea3D
	_hit_shape().disabled = true
	pass


func _update(_delta: float) -> void:
	#When the timer runs out, return to the previous state (fsm.previous_state)
	if update_timer(_delta):
		change_state(fsm.previous_state)
	pass

func _hit_shape() -> CollisionShape3D:
	return obj.get_node("Direction/HitArea3D/CollisionShape3D")
