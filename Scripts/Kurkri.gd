extends CharacterBody2D

@export var health = 200
@onready var player = get_node("/root/Main/Player")

func _physics_process(delta):
	var speed: float = 0.01 # put wanted speed here
	look_at(player.global_position)
	self.position = lerp(self.position,player.global_position,speed)
func onDamage(damage_number):
	print("damage called: ",damage_number)
	health = health - damage_number
	
	if health <= 0:
		queue_free()
