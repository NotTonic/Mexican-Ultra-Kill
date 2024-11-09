extends CharacterBody3D

var player = null

const SPEED = 5.0

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D


func _ready():
	player = get_node(player_path)



func _process(_delta):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * SPEED
	look_at(Vector3(player.global_position.x, global_transform.origin.y, player.global_postion.z), Vector3.UP)
	
	

	move_and_slide()