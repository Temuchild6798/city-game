extends CharacterBody3D


var speed = 5
var jump = 10
var dead = false
var front_view = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	use_item()
	if Input.is_action_just_pressed("front_view"):
		front_view = true
		%pivot_point.rotation_degrees.y = 180
	if Input.is_action_just_released("front_view"):
		front_view = false
		%pivot_point.rotation_degrees.y = 0
func _physics_process(delta):
	var input_direction = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		input_direction += -global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_direction += global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_direction += -global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_direction += global_transform.basis.x
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	if Input.is_action_pressed("sprint"):
		speed = 10
		%AnimationPlayer.speed_scale = 40
	else:
		speed = 4
		%AnimationPlayer.speed_scale = 9
	if not is_on_floor():
		velocity.y -= 9.8 * 3 * delta 
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.z * speed
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = 10
	if input_direction.length() > 0:
		%AnimationPlayer.play("move")
	else:
		%AnimationPlayer.play("RESET")
	if dead == false:
		move_and_slide()
		
func _unhandled_input(event: InputEvent) -> void:
	if front_view:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.3
		%pivot_point.rotation_degrees.x -= event.relative.y * 0.3
		%pivot_point.rotation_degrees.x = clamp(%pivot_point.rotation_degrees.x, -60, 60)
func use_item():
	if Input.is_action_just_pressed("shoot"):
		const boulder = preload("res://scenes/boulder.tscn")
		var new_boulder = boulder.instantiate()
		new_boulder.global_transform = %muzzle.global_transform
		get_tree().root.add_child(new_boulder)
		var launch_direction = -%muzzle.global_transform.basis.z
		new_boulder.apply_central_impulse(launch_direction * 90.0)
