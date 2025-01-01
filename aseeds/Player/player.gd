extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var Combat_Mode :bool = false

@onready var animation_tree :AnimationTree = $AnimationTree

func Update_animation_prameters():
	if(!Combat_Mode):
		if(Input.is_action_just_pressed("combat")):
			animation_tree["parameters/conditions/To_combat"] = false
			animation_tree["parameters/conditions/Combat"] = false
			animation_tree["parameters/conditions/To_idel"] = true
			
		if(Input.is_action_pressed("left") || Input.is_action_pressed("right")):
			animation_tree["parameters/conditions/Idel"] = false
			animation_tree["parameters/conditions/Is_moving"] = true
		elif(velocity == Vector2.ZERO):
			animation_tree["parameters/conditions/Idel"] = true
			animation_tree["parameters/conditions/Is_moving"] = false
	else :
		if(Input.is_action_just_pressed("combat")):
			animation_tree["parameters/conditions/Idel"] = false
			animation_tree["parameters/conditions/To_idel"] = false
			animation_tree["parameters/conditions/To_combat"] = true
		if(Input.is_action_pressed("left") || Input.is_action_pressed("right")):
			animation_tree["parameters/conditions/Combat"] = false
			animation_tree["parameters/conditions/Combat_moving"] = true
		elif(velocity == Vector2.ZERO):
			animation_tree["parameters/conditions/Combat"] = true
			animation_tree["parameters/conditions/Combat_moving"] = false
	

func _ready() -> void:
	animation_tree.active = true

func _process(_delta: float) -> void:
	Update_animation_prameters()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * .5 * delta
	
	if Input.is_action_just_pressed("combat"):
		Combat_Mode = !Combat_Mode

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("left"):
		$AnimatedSprite2D.flip_h = true
		
	elif Input.is_action_just_pressed("right"):
		$AnimatedSprite2D.flip_h = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
