extends CharacterBody3D

@export var walk_speed: float = 8.0
@export var sprint_speed: float = 14.0
@export var crouch_speed: float = 4.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3

# Variabel untuk tinggi collision saat berdiri dan merunduk
@export var default_height: float = 2.0
@export var crouch_height: float = 1.0

@onready var head: Node3D = $Head
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var camera: Camera3D = $Head/Camera3D
@onready var hud = $HUD

var camera_x_rotation: float = 0.0
var current_speed: float = walk_speed
var inventory: Array = []
var coin_count: int = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

func _physics_process(delta):
	var movement_vector = Vector3.ZERO

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	movement_vector = movement_vector.normalized()

	# Logika Sprinting dan Crouching
	if Input.is_action_pressed("crouch") and is_on_floor():
		current_speed = crouch_speed
		# Ubah tinggi collision shape dan posisi kamera secara perlahan (lerp)
		collision_shape.shape.height = lerp(collision_shape.shape.height, crouch_height, delta * 10.0)
		head.position.y = lerp(head.position.y, crouch_height / 2.0, delta * 10.0)
	elif Input.is_action_pressed("sprint") and is_on_floor():
		current_speed = sprint_speed
		collision_shape.shape.height = lerp(collision_shape.shape.height, default_height, delta * 10.0)
		head.position.y = lerp(head.position.y, default_height / 2.0, delta * 10.0)
	else:
		current_speed = walk_speed
		collision_shape.shape.height = lerp(collision_shape.shape.height, default_height, delta * 10.0)
		head.position.y = lerp(head.position.y, default_height / 2.0, delta * 10.0)

	# Aplikasikan current_speed ke pergerakan
	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not Input.is_action_pressed("crouch"):
		velocity.y = jump_power

	move_and_slide()
	
func add_item_to_inventory(item_name: String):
	if item_name == "Koin":
		coin_count += 1
		hud.update_coin_display(coin_count) # Update teks di layar
		print("Dapat koin! Total koin: ", coin_count)
	else:
		inventory.append(item_name)
		print("Inventory saat ini: ", inventory)
