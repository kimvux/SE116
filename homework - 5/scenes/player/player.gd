class_name Player
extends BaseCharacter

## Turned on throughout the Hurt state so one hit doesn't drain health every single frame in a row.
var is_invulnerable: bool = false

## Whatever the fox is carrying right now (null = empty hands).
var held: BaseCharacter = null

@onready var hold_point: Marker3D = $HoldPoint
@onready var grab_area: Area3D = $Direction/GrabArea3D
@onready var bullet_factory: Node3DFactory = $Direction/Factory

@export var bullet_speed: float = 12


func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Idle)
	super._ready()


## Every state of the fox can take damage, so this calls straight into the current state; whichever
## state doesn't want to lose health (Dead) overrides take_damage().
func _on_hurt_area_3d_hurt(_direction: Vector3, damage: float) -> void:
	if is_invulnerable:
		return
	fsm.current_state.take_damage(int(damage))


## The nearest body in front of the fox that can be picked up, or null.
func find_carry_target() -> BaseCharacter:
	var best: BaseCharacter = null
	var best_dist := INF
	for body in grab_area.get_overlapping_bodies():
		if body is BaseCharacter and body != self and body.can_be_carried():
			var dist := global_position.distance_squared_to(body.global_position)
			if dist < best_dist:
				best = body
				best_dist = dist
	return best


## Same as the barrel: spawn a bullet at the Factory and push it in the facing direction.
func fire() -> void:
	var bullet := bullet_factory.create() as RigidBody3D
	if bullet != null:
		bullet.apply_impulse(forward() * bullet_speed)
