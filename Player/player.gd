extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY_HIGH = -200.0
const JUMP_VELOCITY_LOW = -100.0

@export var BOOK : Node2D
@export var Player_Assist: AnimatedSprite2D
@export var animations: AnimationTree
@export var Footsteps_VFX :AudioStreamPlayer2D
@export var Ground_detector : RayCast2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var delta_time: float = 0.0

# jump
var HOLD_THRESHOLD = 0.3
var press_time = 0.0
var jump_height = JUMP_VELOCITY_LOW
var is_holding = false
var is_jumping = false

var CombatMode = false
var targeted_enemy 
var enemy_distance = 0
var all_enemys_can_by_targeted = []


enum Player_States{
	IDEL,
	WALKS,
	JUMPS,
	FOLLING,
	DEATH
}

var currnt_state = Player_States.IDEL



func Update_Animation_Parameters():
	if currnt_state == Player_States.DEATH:
		animations["parameters/conditions/Is_Moving"] = false
		animations["parameters/conditions/Idel"] = false
		animations["parameters/conditions/Death"] = true
	else:
		if !Ground_detector.is_colliding():
			if velocity.x == 0:
				currnt_state = Player_States.IDEL
				animations["parameters/conditions/Idel"] = true
				animations["parameters/conditions/Is_Moving"] = false
			if velocity.x != 0:
				currnt_state = Player_States.WALKS
				animations["parameters/conditions/Idel"] = false
				animations["parameters/conditions/Is_Moving"] = true
		else:
			animations["parameters/conditions/Idel"] = false
			animations["parameters/conditions/Is_Moving"] = false

func handle_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func handle_book_placement(placement:bool):
	if placement:
		BOOK.position = Vector2(-33,-86)
	else :
		BOOK.position = Vector2(33,-86)

func handle_movement(direction: float) -> void:
	if direction != 0 and currnt_state != Player_States.DEATH:
		Player_Assist.flip_h = direction < 0
		handle_book_placement(direction < 0)
		velocity.x = direction * SPEED
		#Footsteps_VFX.play()
	else:
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
		velocity.y = JUMP_VELOCITY_HIGH
		is_holding = false
		is_jumping = false

func _physics_process(delta: float) -> void:
	delta_time = delta
	Update_Animation_Parameters()
	
	CombatMode = all_enemys_can_by_targeted.size() > 0
	#print(CombatMode)
	if CombatMode:
		for enemy in all_enemys_can_by_targeted:
			var enemy_pos = enemy.position 
			var distance = enemy_pos.distance_to(self.position)
			if enemy_distance > 0:
				if enemy_distance > distance:
					enemy_distance = distance
			else :
				enemy_distance = distance
	else :
		enemy_distance = 0
	print(enemy_distance)
	# Add the gravity.
	if not is_on_floor():
		handle_gravity(delta)
	
	# jump handler
	if currnt_state != Player_States.DEATH:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			handle_normal_jumping()
		elif Input.is_action_pressed("jump") and is_holding and is_jumping:
			handle_hold_jumping(delta_time)
		elif Input.is_action_just_released("jump"):
			is_holding = false
	# Handle movement
	var direction := Input.get_axis("left", "right")
	handle_movement(direction)
	
	move_and_slide()

func _on_health_health_depleted() -> void:
	currnt_state = Player_States.DEATH

func _on_enemyditction_area_entered(area: Area2D) -> void:
	if area is HitBox:
		all_enemys_can_by_targeted.append(area)

func _on_enemyditction_area_exited(area: Area2D) -> void:
	if area is HitBox:
		all_enemys_can_by_targeted.erase(area)
