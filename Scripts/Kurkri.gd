extends CharacterBody2D

@export var health = 200
@onready var player = get_node("/root/Main/Player")
@onready var speed = 200

func _physics_process(delta):
	look_at(player.global_position)
	var direction = (player.global_position - self.position).normalized()
	self.position += direction * speed * delta
	$AnimatedSprite2D.play("default")
	
func onDamage(damage_number):
	print("damage called: ",damage_number)
	health = health - damage_number
	
	if health <= 0:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.on_damage(500)
		
