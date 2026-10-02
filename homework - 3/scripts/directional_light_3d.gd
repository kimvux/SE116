extends DirectionalLight3D

var day_color = Color("ffffffff")
var night_color = Color("f15800ff")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation.x += delta * (PI/30)
	var t = (sin(rotation.x) + 1.0) / 2.0
	light_color = day_color.lerp(night_color, t)
	#self.light_color.v = (sin(rotation.x+90) + 1) / 2
	pass
