extends CharacterBody3D


var speed = 5
var jump = 10

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

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
		speed = 7
	else:
		speed = 5
	if not is_on_floor():
		velocity.y -= 9.8 * 3 * delta 
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.z * speed
	
	if input_direction.length() > 0:
		%AnimationPlayer.play("move")
	else:
		%AnimationPlayer.play("RESET")
	move_and_slide()
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		%pivot_point.rotation_degrees.x -= event.relative.y * 0.5
		%pivot_point.rotation_degrees.x = clamp(%pivot_point.rotation_degrees.x, -60, 60)
