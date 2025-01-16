extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@export var Player_Assist: AnimatedSprite2D
@export var animations: AnimationTree
@export var Footsteps_VFX :AudioStreamPlayer2D
var CombatMode = false


func Update_Animation_Parameters():
	if Input.is_action_just_pressed("death"):
		animations["parameters/conditions/Death"] = true
		animations["parameters/conditions/Idel"] = false
	if Input.is_action_just_pressed("combat") && !CombatMode:
		animations["parameters/conditions/To_Combat"] = true
		animations["parameters/conditions/Out_Combat"] = false
		animations["parameters/conditions/Idel"] = false
		CombatMode = !CombatMode
	elif Input.is_action_just_pressed("combat") && CombatMode:
		animations["parameters/conditions/To_Combat"] = false
		animations["parameters/conditions/Out_Combat"] = true
		animations["parameters/conditions/Ready_Idel"] = false
		CombatMode = !CombatMode
	if !CombatMode:
		
		if velocity.x == 0:
			animations["parameters/conditions/Idel"] = true
			animations["parameters/conditions/Is_moving"] = false
		else:
			animations["parameters/conditions/Idel"] = false
			animations["parameters/conditions/Is_moving"] = true
	else:
		
		if velocity.x == 0:
			animations["parameters/conditions/Ready_Idel"] = true
			animations["parameters/conditions/Ready_Is_moving"] = false
		else:
			animations["parameters/conditions/Ready_Idel"] = false
			animations["parameters/conditions/Ready_Is_moving"] = true

func _physics_process(delta: float) -> void:
	Update_Animation_Parameters()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		#loking at laft or right
		if direction > 0:
			Player_Assist.flip_h = false
		else:
			Player_Assist.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
