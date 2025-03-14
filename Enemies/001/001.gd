extends CharacterBody2D



@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 120
@export var ACCELERATION: int = 200

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var PlayerDetector: RayCast2D = $AnimatedSprite2D/PlayerDetector
@onready var DamegIndecater: CollisionShape2D = $AnimatedSprite2D/HitBox/CollisionShape2D
@onready var GroundDetector: RayCast2D = $AnimatedSprite2D/Ground_detector/RayCast2D2
@onready var timer = $Timer

var gravity: float = 10000
var direction: Vector2
var rigth_bounds:Vector2
var left_bounds:Vector2

enum States{
	WANDER,
	CHASE,
	FROZEN
}

var currnt_state = States.WANDER

func _ready() -> void:
	left_bounds = self.position + Vector2(-200,0)
	rigth_bounds = self.position + Vector2(200,0)


func _physics_process(delta: float) -> void:
	if currnt_state == States.WANDER:
		$Label.text = 'WANDER'
	else :
		$Label.text = 'CHASE'
	handle_gravity(delta)
	#handle_movment(delta)
	change_direction()
	lock_for_player()

func lock_for_player():
	if PlayerDetector.is_colliding():
		var collider = PlayerDetector.get_collider()
		if collider == player:
			chase_player()
		elif currnt_state == States.CHASE:
			stop_chase()
	elif currnt_state == States.CHASE:
			stop_chase()

func chase_player() -> void:
	timer.stop()
	currnt_state = States.CHASE

func stop_chase() -> void:
	if timer.time_left <= 0:
		timer.start()

func handle_movment(delta: float) -> void:
	if currnt_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	elif currnt_state == States.CHASE:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
	elif currnt_state == States.FROZEN:
		velocity = Vector2.ZERO
	move_and_slide()

func change_direction() -> void:
	if currnt_state == States.WANDER:
		if sprite.flip_h:
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1,0)
			else:
				sprite.flip_h = false
				PlayerDetector.target_position = Vector2(100,0)
				DamegIndecater.position = Vector2(24,-51)
		else:
			if self.position.x <= rigth_bounds.x:
				direction = Vector2(1,0)
			else:
				sprite.flip_h = true
				PlayerDetector.target_position = Vector2(-100,0)
				DamegIndecater.position = Vector2(-24,-51)
	elif currnt_state == States.CHASE:
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if GroundDetector.is_colliding():
			if direction.x == 1:
				sprite.flip_h = false
				PlayerDetector.target_position = Vector2(100,0)
				DamegIndecater.position = Vector2(24,-51)
			else:
				sprite.flip_h = true
				PlayerDetector.target_position = Vector2(-100,0)
				DamegIndecater.position = Vector2(-24,-51)
		else :
			currnt_state = States.FROZEN
	elif currnt_state == States.FROZEN:
		currnt_state = States.WANDER

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = gravity * delta

func _on_health_health_depleted() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	currnt_state = States.WANDER
