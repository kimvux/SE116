extends RigidBody3D

@export var lifetime: float = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitArea3D.hitted.connect(_on_hitted)
	body_entered.connect(_on_body_entered)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	pass # Replace with function body.


func _on_hitted(_area: Area3D) -> void:
	queue_free()

func _on_body_entered(_body: Node3D) -> void:
	queue_free()
