extends PlayerState

func _enter() -> void:
	#Switch the animation to "dead"
	#Stop moving completely
	#Set the timer to 2 seconds
	obj.change_animation("dead")
	obj.stop_move()
	timer = 2
	pass


func _update(_delta: float) -> void:
	#When the timer runs out, reload the level
	if update_timer(_delta):
		obj.get_tree().reload_current_scene()
	pass


#Already dead, so no more damage
func take_damage(_damage: int = 1) -> void:
	pass
