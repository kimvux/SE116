extends EnemyState

## Flying along an arc after being thrown. Gravity (BaseCharacter._update_movement) bends the path;
## the HitArea3D hurts whatever enemy it passes through. Landing ends the flight.

## Short grace period so the frame of the throw itself doesn't count as "already on the floor".
const MIN_FLIGHT_TIME := 0.1

func _enter() -> void:
	obj.velocity = obj.throw_velocity
	obj.movement_enabled = true
	obj.get_node("CollisionShape3D").set_deferred("disabled", false)
	_hit_shape().set_deferred("disabled", false)
	timer = MIN_FLIGHT_TIME


func _exit() -> void:
	_hit_shape().set_deferred("disabled", true)
	obj.stop_horizontal()


func _update(delta: float) -> void:
	update_timer(delta)
	if timer <= 0 and obj.is_on_floor():
		change_state(fsm.default_state)


func take_damage(_damage_dir: Vector3, _damage: float) -> void:
	pass


func _hit_shape() -> CollisionShape3D:
	return obj.get_node("Direction/HitArea3D/CollisionShape3D")
