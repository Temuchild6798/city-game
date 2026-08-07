extends Node3D
@onready var neck_joint: Joint3D = $"ragdoll-thing/ragdoll/neck-joint"
func break_neck():
	neck_joint.queue_free()
