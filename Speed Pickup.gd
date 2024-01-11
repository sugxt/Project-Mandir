extends Area2D
@onready var item_name = 'Speed'


func _on_body_entered(body):
	if body.name == "Player":
		body.get_item(item_name)
		queue_free()
func _process(delta):
	$AnimationPlayer.play("Scale Up")
