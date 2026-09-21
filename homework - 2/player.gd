@tool
extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

const SPEED = 5.0
var timer = 0.0
var is_moving = false
var direction

func _ready() -> void:
	direction = global_position

func _physics_process(delta: float) -> void:

	
	
	if !is_moving:
		velocity = Vector3.ZERO
		timer += delta
	else:
		velocity = (navigation_agent_3d.get_next_path_position() - global_position).normalized() * SPEED
		pass
	if timer > 5:
		timer = 0
		is_moving = true
		var x = randf_range(5,15) * (1 if randf() < 0.5 else -1)
		var z = randf_range(5,15) * (1 if randf() < 0.5 else -1)
		direction = Vector3(x,0,z)
		var safe_target = NavigationServer3D.map_get_closest_point(navigation_agent_3d.get_navigation_map(),direction)
		navigation_agent_3d.target_position = safe_target
		print("move")
	
	move_and_slide()


func _on_navigation_agent_3d_target_reached() -> void:
	print("stop")
	is_moving = false
	pass # Replace with function body.
