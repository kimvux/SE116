extends EnemyState

func _enter() -> void:
	obj.change_animation("hurt")
	timer = 0.2

func _exit() -> void:
	obj.stop_horizontal()
# Called when the node enters the scene tree for the first time.

func _update( _delta: float) -> void:
	if update_timer(_delta):
		if obj.health <= 0:
			change_state(fsm.states.dead)
		else:
			change_state(fsm.previous_state)

func take_damage(_damage_dir:Vector3, _damage: float) -> void:
	pass
