extends Area2D
@onready var itemName = "Gun"


func _on_body_entered(body):
	body.get_item(itemName)
	queue_free()
func _process(delta):
	$AnimationPlayer.play("scale_up")
