extends CharacterBody3D


var speed = 2
var jump = 10

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
