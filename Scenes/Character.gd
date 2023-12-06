extends CharacterBody2D

@export var MAXSPEED = 400
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	return input_direction.normalized()

func _physics_process(delta):
	move(delta)

func move(delta):
	axis = get_input()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION + delta)
	else:
		apply_movement(axis* ACCELERATION * delta)
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity= Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAXSPEED)
	
