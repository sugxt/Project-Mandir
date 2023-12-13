extends CharacterBody2D

@export var health = 200
@onready var player = get_node("/root/Main/Player")

func _physics_process(delta):
	var speed: float = 0.03 # put wanted speed here
	look_at(player.global_position)
	self.position = lerp(self.position,player.global_position,speed)
func onDamage(damage_number):
	print("damage called: ",damage_number)
	health = health - damage_number
	
	if health <= 0:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.on_damage(500)
		if $Area2D.has_overlapping_bodies():
			await get_tree().create_timer(1).timeout
			body.on_damage(200) # Change it so the damage keeps happening instead of once
		
