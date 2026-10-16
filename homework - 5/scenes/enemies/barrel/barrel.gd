extends EnemyCharacter


@export var bullet_speed: float = 12
@onready var bullet_factory: Node3DFactory = $Direction/BullerFactory

func _ready() -> void:
	fsm = FSM.new(self,$States,$States/Idle)
	super._ready()
	
func fire() -> void:
	var bullet := bullet_factory.create() as RigidBody3D
	if bullet != null:
		bullet.apply_impulse(forward() * bullet_speed)


#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
