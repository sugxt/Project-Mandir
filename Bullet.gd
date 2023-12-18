extends Area2D

@export var speed = 2500
@export var time_to_live = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = time_to_live
	$Timer.start()
	$AnimatedSprite2D.play("BulletAnim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		return
	body.onDamage(200)
	queue_free()

