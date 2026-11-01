extends CharacterBody3D

## Test player using the KayKit Knight model with Rig_Medium animations.

#const ANIM_LIBS: Dictionary = {
	#"Move": "res://assets/KayKit_Adventurers_2.0_FREE/Animations/gltf/Rig_Medium/Rig_Medium_MovementBasic.glb",
	#"General": "res://assets/KayKit_Adventurers_2.0_FREE/Animations/gltf/Rig_Medium/Rig_Medium_General.glb",
#}

@export var walk_speed: float = 4.0
@export var run_speed: float = 7.0
@export var jump_speed: float = 10.0
@export var gravity: float = 24.0
@export var turn_speed: float = 12.0

@onready var model: Node3D = $Model

@onready var anim_player: AnimationPlayer = $Model/AnimationPlayer

func _ready() -> void:
	# The Knight file has no animations, so borrow the libraries from the
	# KayKit animation files. Both share the Rig_Medium skeleton layout.
	#anim_player = AnimationPlayer.new()
	#model.add_child(anim_player)
	#for lib_name in ANIM_LIBS:
		#var res: Resource = load(ANIM_LIBS[lib_name])
		#if res is AnimationLibrary:
			#anim_player.add_animation_library(lib_name, res)
		#else:
			#var source: Node = res.instantiate()
			#var source_player: AnimationPlayer = source.find_child("AnimationPlayer", true, false)
			#anim_player.add_animation_library(lib_name, source_player.get_animation_library(""))
			#source.free()
	#for loop_anim in ["General/Idle_A", "Move/Walking_A", "Move/Running_A", "Move/Jump_Idle"]:
		#anim_player.get_animation(loop_anim).loop_mode = Animation.LOOP_LINEAR
	anim_player.play("General/Idle_A")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

	var input := Input.get_vector("left", "right", "up", "down")
	var running := Input.is_action_pressed("run")
	var speed := run_speed if running else walk_speed
	velocity.x = input.x * speed
	velocity.z = input.y * speed
	move_and_slide()

	# Face the moving direction (the model looks along +Z)
	if input != Vector2.ZERO:
		var target_yaw := atan2(input.x, input.y)
		model.rotation.y = lerp_angle(model.rotation.y, target_yaw, turn_speed * delta)

	_update_animation(input, running)

func _update_animation(input: Vector2, running: bool) -> void:
	var anim := "General/Idle_A"
	if not is_on_floor():
		anim = "Move/Jump_Idle"
	elif input != Vector2.ZERO:
		anim = "Move/Running_A" if running else "Move/Walking_A"
	if anim_player.current_animation != anim:
		anim_player.play(anim, 0.15)
