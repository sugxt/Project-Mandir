extends Area2D

var speed = 900

func _physics_process(delta):
	position += transform.x * speed * delta
