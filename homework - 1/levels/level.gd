extends Node3D

func _init() -> void:
	pass

func _ready() -> void:
	var sprite3d = Sprite3D.new()
	sprite3d.texture = load("res://assets/terrain/palm_tree.png")
	sprite3d.pixel_size = 0.0625
	sprite3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite3d.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite3d.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	add_child(sprite3d)
	sprite3d.position = Vector3(2.0,4.0,1.0)
	
	var tree = Sprite3D.new()
	tree.texture = load("res://assets/terrain/palm_tree.png")
	tree.pixel_size = 0.0625
	tree.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	tree.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	tree.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	tree.scale = Vector3(1.2,1.2,1.2)
	tree.flip_h = true
	add_child(tree)
	tree.position = Vector3(15.0,4.0,5.0)
	pass
