extends Sprite2D
@onready var parent = $".."

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressing = false

@export var maxLength = 50
@export var deadzone = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()

func _on_Button_button_down():
	pressing = true


func _on_Button_button_up():
	pressing = false
