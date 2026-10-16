extends EnemyState

## Being carried overhead: lies still, doesn't fall, doesn't walk, doesn't collide and takes no hits.
## Following the carrier is free — the object is a child of the carrier's HoldPoint.

func _enter() -> void:
	obj.stop_move()


func take_damage(_damage_dir: Vector3, _damage: float) -> void:
	pass
