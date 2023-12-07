extends CharacterBody2D

@export var MAXSPEED = 400
@export var ACCELERATION = 1800
@export var FRICTION = 1200
@export var projectile: PackedScene
@onready var axis = Vector2.ZERO



func get_input():
	if Input.is_action_just_pressed("shoot"): shoot()
	var input_direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	return input_direction.normalized()

func _physics_process(delta):
	move(delta)

func move(delta):
	axis = get_input()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION + delta)
		$Sprite2D/AnimationPlayer.play("idle_animation")
	else:
		apply_movement(axis* ACCELERATION * delta)
		$Sprite2D/AnimationPlayer.stop()
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity= Vector2.ZERO

func apply_movement(accel):
	velocity += accel * 2
	velocity = velocity.limit_length(MAXSPEED)
	
func shoot():
	var b = projectile.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform
	
