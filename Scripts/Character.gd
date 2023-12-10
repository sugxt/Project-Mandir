extends CharacterBody2D

@export var MAXSPEED = 400
@export var ACCELERATION = 1200
@export var FRICTION = 1200
@export var projectile: PackedScene
@export var shootingDelay: float = 0.3
var canShoot: bool = true
var shootTimer: Timer

@onready var axis = Vector2.ZERO

func _ready():
	shootTimer = $Timer
	shootTimer.wait_time = shootingDelay

func get_input():
	if Input.is_action_just_pressed("shoot") and canShoot:
		shootTimer.start()
		shoot()
	var input_direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	return input_direction.normalized()

func _process(delta):
	move(delta)

func _on_timer_timeout():
	canShoot = true

func _physics_process(delta):
	move_and_slide()

func move(delta):
	axis = get_input()

	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
		$Sprite2D/AnimationPlayer.play("idle_animation")
	else:
		apply_movement(axis * ACCELERATION * delta)
		$Sprite2D/AnimationPlayer.play("walking_animation")

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel * 2
	velocity = velocity.limit_length(MAXSPEED)

func shoot():
	if canShoot:
		var b = projectile.instantiate()
		owner.add_child(b)
		b.transform = $Marker2D.global_transform
		canShoot = false
		shootTimer.start()

