extends RigidBody3D

func _process(delta):
	if global_position.y <= -40.0:
		queue_free()
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("house"):
		$smack.play()
