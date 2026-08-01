extends Node3D

@export var ragdoll_scene: PackedScene
@export var path3d: Path3D
@export var spawn_interval: float = 1.0
@export var walk_speed: float = 4.0

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = true
	timer.timeout.connect(_on_spawn_timer)
	add_child(timer)

func _on_spawn_timer() -> void:
	var new_path_follow = PathFollow3D.new()
	path3d.add_child(new_path_follow)

	var new_ragdoll = ragdoll_scene.instantiate()
	new_path_follow.add_child(new_ragdoll)
	_freeze_all(new_ragdoll)

	var walker = Node.new()
	walker.set_script(preload("res://scripts/path_walker.gd"))
	new_path_follow.add_child(walker)
	walker.set("walk_speed", walk_speed)

func _freeze_all(node: Node) -> void:
	for child in node.get_children():
		if child is RigidBody3D:
			child.freeze = true
		_freeze_all(child)
