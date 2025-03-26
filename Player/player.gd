extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY_HIGH = -300.0
const JUMP_VELOCITY_LOW = -100.0

@export var BOOK : Node2D
@export var Player_Assist: AnimatedSprite2D
@export var animations: AnimationTree
@export var Footsteps_VFX :AudioStreamPlayer2D
@export var land :RayCast2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var delta_time: float = 0.0

# jump
var HOLD_THRESHOLD = 0.3
var press_time = 0.0
var jump_height = JUMP_VELOCITY_LOW
var is_holding = false
var is_jumping = false

var DEATH = false

var CombatMode = false
var LockOn = false
var targeted_enemy : Node2D
var all_enemys_that_can_by_targeted = {}


enum Player_States{
	IDEL,
	WALKS,
	JUMPS,
	FALLING,
	LANDING,
	DEATH
}

var currnt_state = Player_States.IDEL



func Update_Animation_Parameters():
	if currnt_state == Player_States.DEATH:
		$Label.text = "DEATH"
		animations["parameters/conditions/Is_Moving"] = false
		animations["parameters/conditions/Idel"] = false
		animations["parameters/conditions/Death"] = true
	else:
		if currnt_state == Player_States.IDEL:
			$Label.text = "IDEL"
			animations["parameters/conditions/Fall"] = false
			animations["parameters/conditions/Idel"] = true
			animations["parameters/conditions/Is_Moving"] = false
		if currnt_state == Player_States.WALKS :
			$Label.text = "WALKS"
			animations["parameters/conditions/Fall"] = false
			animations["parameters/conditions/Idel"] = false
			animations["parameters/conditions/Is_Moving"] = true
		if currnt_state == Player_States.JUMPS:
			$Label.text = "JUMPS"
			animations["parameters/conditions/Idel"] = false
			animations["parameters/conditions/Is_Moving"] = false
			animations["parameters/conditions/Jump"] = true
		if currnt_state == Player_States.FALLING:
			$Label.text = "FALLING"
			animations["parameters/conditions/Jump"] = false
			animations["parameters/conditions/Fall"] = true
		if currnt_state == Player_States.LANDING:
			$Label.text = "LANDING"
			animations["parameters/conditions/Fall"] = false
			animations["parameters/conditions/Land"] = true

func handle_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func handle_book_placement(placement:bool):
	if placement:
		BOOK.position = Vector2(-33,-86)
	else :
		BOOK.position = Vector2(33,-86)

func handle_movement(direction: float) -> void:
	if direction != 0 and currnt_state != Player_States.DEATH:
		currnt_state = Player_States.WALKS
		Player_Assist.flip_h = direction < 0
		handle_book_placement(direction < 0)
		velocity.x = direction * SPEED
		#Footsteps_VFX.play()
	else:
		currnt_state = Player_States.IDEL
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_normal_jumping() -> void:
	velocity.y = JUMP_VELOCITY_LOW
	press_time = 0.0
	is_holding = true
	is_jumping = true

func handle_hold_jumping(delta: float) -> void:
	press_time += delta
	if press_time < HOLD_THRESHOLD:
		velocity.y = lerp(JUMP_VELOCITY_LOW, JUMP_VELOCITY_HIGH, press_time/HOLD_THRESHOLD)
	else:
		velocity.y = JUMP_VELOCITY_LOW
		is_holding = false
		is_jumping = false

func enemys_pos() -> void:
	for enemy in all_enemys_that_can_by_targeted:
		all_enemys_that_can_by_targeted[enemy] = self.global_position.distance_to(enemy.global_position)

func target(EnmyInRange : bool) -> void:
	enemys_pos()
	if EnmyInRange:
		targeted_enemy = all_enemys_that_can_by_targeted.find_key(all_enemys_that_can_by_targeted.values().pick_random())

func _physics_process(delta: float) -> void:
	delta_time = delta
	if DEATH:
		currnt_state = Player_States.DEATH
	Update_Animation_Parameters()
	CombatMode = all_enemys_that_can_by_targeted.size() > 0
	target(CombatMode)
	# target 
	if Input.is_action_just_pressed("target") and CombatMode:
		for enemy in all_enemys_that_can_by_targeted:
			enemy.Targeted(false)
		targeted_enemy.Targeted(true)
	# Handle movement
	var direction := Input.get_axis("left", "right")
	handle_movement(direction)
	# Add the gravity.
	if not is_on_floor():
		currnt_state = Player_States.JUMPS
		handle_gravity(delta)
		if !is_holding:
			currnt_state = Player_States.FALLING
		if land.is_colliding():
			currnt_state = Player_States.LANDING
	# jump handler
	if !DEATH:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			handle_normal_jumping()
		elif Input.is_action_pressed("jump") and is_holding and is_jumping:
			handle_hold_jumping(delta_time)
		elif Input.is_action_just_released("jump"):
			is_holding = false
	
	
	move_and_slide()

func _on_health_health_depleted() -> void:
	DEATH = true


func _on_enemyditction_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemys"):
		var enemy = body
		all_enemys_that_can_by_targeted.set(enemy,0.0)


func _on_enemyditction_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemys"):
		var enemy = body
		enemy.Targeted(false)
		all_enemys_that_can_by_targeted.erase(enemy)
