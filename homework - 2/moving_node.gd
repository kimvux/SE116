#@tool
extends Node3D
class_name MovingNode

@export var velocity: float = 0.1
var distance = 0.0

func _init() -> void:
	print("Node dc khoi tao!")
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Node da san sang trong Scene tree!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += velocity * delta
	distance += velocity * delta
	#if distance > 3:
		#queue_free()
	pass

func _exit_tree() -> void:
	print("Node bi xoa khoi tree")
	pass
