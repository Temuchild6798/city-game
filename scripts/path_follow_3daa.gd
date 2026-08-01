extends PathFollow3D

@export var walk_speed = 200.0
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	progress += walk_speed * delta
