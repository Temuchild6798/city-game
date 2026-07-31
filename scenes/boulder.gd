extends RigidBody3D

func _process(delta):
	if global_position.y <= -40.0:
		queue_free()
