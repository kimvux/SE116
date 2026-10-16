class_name PlayerState
extends FSMState

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(delta: float) -> void:
	pass

## Reads input, sets the facing direction and horizontal velocity. Returns true if there's input.
## Split out of control_moving() because Carry needs to follow input WITHOUT being pushed into Run.
func move_by_input(speed_scale: float = 1.0) -> bool:
	var input: Vector2 = Input.get_vector("left", "right", "up", "down")
	if input.length() <= 0.1:
		obj.stop_horizontal()
		return false
	obj.change_direction(BaseCharacter.direction_from_input(input))
	obj.velocity.x = obj.movement_speed * speed_scale * input.x
	obj.velocity.z = obj.movement_speed * speed_scale * input.y
	return true

#Control moving and changing state to run
#Return true if moving
func control_moving() -> bool:
	var is_moving := move_by_input()
	if is_moving and obj.is_on_floor():
		change_state(fsm.states.run)
	return is_moving

#Control jumping
#Return true if jumping
func control_jump() -> bool:
	if Input.is_action_just_pressed("jump"):
		obj.jump()
		change_state(fsm.states.jump)
		return true
	return false

#Control attack
#Return true if attacking
func control_attack() -> bool:
	#If the "attack" key is pressed, switch to state Attack and return true
	if Input.is_action_just_pressed("attack"):
		change_state(fsm.states.attack)
		return true
	return false

#Control shooting
#Return true if shooting
func control_shoot() -> bool:
	if Input.is_action_just_pressed("shoot"):
		change_state(fsm.states.shoot)
		return true
	return false

#Control picking something up
#Return true if something was picked up
func control_carry() -> bool:
	if not Input.is_action_just_pressed("carry") or not obj.is_on_floor():
		return false
	var target: BaseCharacter = obj.find_carry_target()
	if target == null:
		return false
	obj.held = target
	change_state(fsm.states.carry)
	return true


func take_damage(_damage: int = 1) -> void:
	#Deduct health via obj.take_damage()
	#Switch to state Dead if out of health, otherwise switch to state Hurt
	obj.take_damage(_damage)
	if obj.health <= 0:
		change_state(fsm.states.dead)
	else:
		change_state(fsm.states.hurt)
		
	pass
