extends CharacterBody3D
@onready var head = $head 
@onready var camera = $head/Camera3D
@onready var hand_gun = $head/Gun
@onready var animation = $head/Sprite2D/AnimationPlayer

var current_speed = 5.0
#99999999999999999999999999999
var shoot = true
var walking_speed = 15.0
const sprint_speed = 15.0
const jump_velocity = 6
const bob_freq = 2.0
const bob_amp = 0.05
var t_bob = 0.0
const mouse_sens = 0.4
var gravity = 9.3
var dashing = false
var dashes = 3.0
#bullet
var bullet = load("res://scenes/bullet.tscn")
var instance
var shot = false
var cooldown = true
var jumps = 2
#PAUSE MENU EVENT
func _unhandled_input(_event):
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		

	
func _physics_process(delta):
	#my own inputs
	if Input.is_action_pressed("shoot") and cooldown == true:
		shot = true
	if shot == true:
		cooldown = false
		
		instance = bullet.instantiate()
		instance.position = hand_gun.global_position
		instance.transform.basis = hand_gun.global_transform.basis
		
		animation.play("shoot")
		
		get_parent().add_child(instance)
		await get_tree().create_timer(1.0).timeout
		get_parent().remove_child(instance)
		cooldown = true
		
	if shot == true:
		
		animation.play("shoot")
		shot = false
	else:
		animation.play("RESET")
	if dashes < 3:
		dashes+=0.01
		print(dashes)
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		jumps=2
		
		
		
		
		
	
	if Input.is_action_just_pressed("ui_accept") and jumps > 0:
		velocity.y = jump_velocity
		jumps-=1
		
	var input_dir = Input.get_vector("left", "right", "foward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and not dashing:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
	elif not dashing:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	if Input.is_action_pressed("dash") and dashes>=1 and not dashing:
		dashing = true
		dashes-=1
		print(dashes)
		if direction==Vector3(0,0,0):
			direction = camera.project_ray_normal(Vector2(1152/2,649/2))
			direction.y=0
		print(direction*20)
		velocity = direction*20
		await get_tree().create_timer(0.3).timeout
		dashing=false
		
	move_and_slide()
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	return pos
	
