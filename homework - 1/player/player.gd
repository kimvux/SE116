extends CharacterBody3D

@export var gravity = 60.0
@export var run_speed = 12.0
@export var jump_speed = 17.0

const JUMP_SMOKE = preload("res://player/smoke.tscn")

var floor_time = 0


enum {IDLE, WALK, JUMP}
var state = IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_state(IDLE)
	pass # Replace with function body.

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimatedSprite3D.play("idle")
		WALK:
			$AnimatedSprite3D.play("walk")
		JUMP:
			$AnimatedSprite3D.play("jump")

func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	
	if velocity.x > 0:
		velocity.x -= 0.5
	elif velocity.x < 0:
		velocity.x += 0.5
	
	velocity.z = 0
	
	if right:
		if abs(velocity.x) < run_speed:
			velocity.x += 1.5
		$AnimatedSprite3D.flip_h = false
	if left:
		if abs(velocity.x) < run_speed:
			velocity.x -= 1.5
		$AnimatedSprite3D.flip_h = true
	if jump and is_on_floor():
		smoke_effect()
		if (floor_time < 0.05):
			velocity.y = jump_speed * 2
		else:
			velocity.y = jump_speed
	pass

func update_state():
	if state == IDLE and velocity.x != 0:
		change_state(WALK)
	if state == WALK and velocity.x == 0:
		change_state(IDLE)
	if state in [IDLE,WALK] and !is_on_floor():
		change_state(JUMP)
		$Jump.play()
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	pass

func _physics_process(delta: float) -> void:
	velocity.y -= gravity * delta
	if is_on_floor():
		floor_time += delta
	else:
		floor_time = 0
	update_state()
	get_input()
	move_and_slide()
	pass

func smoke_effect():
	var smoke = JUMP_SMOKE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	pass
