extends CharacterBody2D

@export var player_health = 1200
@export var max_speed = 400
@export var acceleration = 1200
@export var friction = 1200
@export var projectile: PackedScene
@export var shooting_delay: float = 0.7
var has_gun: bool = false
var can_shoot: bool = true
var shoot_timer: Timer
var gun_ammo: int = 0

@onready var axis = Vector2.ZERO

func _ready():
	shoot_timer = $Timer
	shoot_timer.wait_time = shooting_delay

func get_input():
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot_timer.start()
		shoot()
	var input_direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	return input_direction.normalized()

func _process(delta):
	move(delta)

func _on_timer_timeout():
	can_shoot = true

func _physics_process(delta):
	move_and_slide()

func move(delta):
	axis = get_input()

	if has_gun:
		$UpperShoot.hide()
		play_gun_animations(axis, delta)
	else:
		$UpperShoot.show()
		play_no_gun_animations(axis, delta)

func play_gun_animations(axis, delta):
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
		$AnimatedSprite2D.play("gun_idle")
	else:
		apply_movement(axis * acceleration * delta)
		$AnimatedSprite2D.play("gun_walking")

func play_no_gun_animations(axis, delta):
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
		$AnimatedSprite2D.play("idle")
	else:
		apply_movement(axis * acceleration * delta)
		$AnimatedSprite2D.play("running")

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel * 2
	velocity = velocity.limit_length(max_speed)

func shoot():
	if has_gun and gun_ammo>0:
		gun_ammo -= 1
		var b = projectile.instantiate()
		owner.add_child(b)
		b.transform = $Marker2D.global_transform
		await get_tree().create_timer(1).timeout
		if gun_ammo <=0:
			has_gun = false
		return
	if can_shoot:
		$UpperShoot.play("throwing")
		var b = projectile.instantiate()
		owner.add_child(b)
		b.transform = $Marker2D.global_transform
		can_shoot = false
		shoot_timer.start()

func on_damage(damage):
	print("Damage Called")
	player_health -= damage
	if player_health <= 0:
		print("Death")
		get_tree().reload_current_scene()

func get_item(item):
	if item == "Gun":
		has_gun = true
		gun_ammo = 10
