extends Area2D

@export var speed = 1500
@export var time_to_live = 1
func _ready():
	$Timer.wait_time = time_to_live
	$Timer.start()
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	body.onDamage(100)
	queue_free()
