extends Node3D
@onready var neck_joint: Joint3D = $"neck-joint"
@onready var qjoint: Joint3D = $"left-shoulder-joint"
@onready var wjoint: Joint3D = $"left-elbow-joint"
@onready var ejoint: Joint3D = $"right-shoulder-joint"
@onready var rjoint: Joint3D = $"right-elbow-joint"
@onready var tjoint: Joint3D = $"left-hip-joint"
@onready var yjoint: Joint3D = $"left-knee-joint"
@onready var ujoint: Joint3D = $"right-hip-joint"
@onready var ijoint: Joint3D = $"right-knee-joint"

var neck_broken := false

func break_neck():
	if neck_broken:
		return
	if neck_joint:
		neck_joint.queue_free()
		qjoint.queue_free()
		wjoint.queue_free()
		ejoint.queue_free()
		rjoint.queue_free()
		tjoint.queue_free()
		yjoint.queue_free()
		ujoint.queue_free()
		ijoint.queue_free()
		neck_broken = true
	else:
		print("neck joint not found!")
