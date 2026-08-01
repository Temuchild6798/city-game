extends Node

var walk_speed: float = 2.0

func _physics_process(delta):
	var pf = get_parent() as PathFollow3D
	if pf:
		pf.progress += walk_speed * delta
