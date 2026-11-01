extends AnimatableBody3D

@export var offset := Vector3(0,4,0)
@export var speed := 2.0
@export var wait_time := 1

var _start: Vector3
var _going_out := true
var _wait := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if _wait > 0.0:
		_wait -= delta
		return
	var target := _start + offset if _going_out else _start
	position = position.move_toward(target,speed * delta)
	if position.is_equal_approx(target):
		_going_out = not _going_out
		_wait = wait_time
	pass
