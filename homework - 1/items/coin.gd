extends Area3D

var fall_speed = 0
var gra = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite3D.play("default")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += Vector3.DOWN * fall_speed * delta
	pass


func _on_body_entered(body: Node3D) -> void:
	$AnimatedSprite3D.play("collected")
	$Coin.play()
	pass # Replace with function body.


func _on_animated_sprite_3d_animation_finished() -> void:
	if $AnimatedSprite3D.animation == "collected":
		queue_free()
	pass # Replace with function body.
