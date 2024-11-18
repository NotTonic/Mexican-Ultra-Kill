extends CharacterBody3D

var player = null

var speed = 5.0  # Movement speed
var height = 5.0  # Desired height above the ground
var tolerance = 0.5  # Distance threshold to the target point
var dashing = false
var health = 100
@export var player_path : NodePath
@onready var this = get_node("BOX")
@onready var nav_agent = $NavigationAgent3D
var this_pos 

func _ready():
	player = get_node(player_path)



func _process(_delta):
	var target_position = Vector3(player.global_transform.origin.x, height, player.global_transform.origin.z)
	nav_agent.set_target_position(target_position)
	var next_nav_point = nav_agent.get_next_path_position()
	next_nav_point.y = height
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	move_and_slide()
	
	if health == 0:
		queue_free()
		
func _on_area_3d_area_entered(area: Area3D) -> void:
	health -= 20
