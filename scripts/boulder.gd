extends RigidBody3D
signal hit_enemy(enemy: Node3D)

func _process(delta):
	if global_position.y <= -40.0:
		queue_free()
func _on_body_entered(body):
	if body.is_in_group("house"):
		$smack.play()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		print("ENEMY HITTTTTT")
		hit_enemy.emit(body)
