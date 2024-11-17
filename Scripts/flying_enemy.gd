extends CharacterBody3D

var player = null

var speed = 5.0
var dashing = false
var health = 100
@export var player_path : NodePath
@onready var this = get_node("BOX")
@onready var nav_agent = $NavigationAgent3D
var this_pos 

func _ready():
	player = get_node(player_path)



func _process(_delta):
	
	velocity = Vector3.ZERO
	nav_agent.set_target_position(Vector3(player.global_transform.origin.x, player.global_transform.origin.y, player.global_transform.origin.z))
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	

	look_at(Vector3(player.global_transform.origin.x, global_transform.origin.y, player.global_transform.origin.z), Vector3.UP) #looks at player

	

	move_and_slide()
	
	if health == 0:
		queue_free()
		
func _on_area_3d_area_entered(area: Area3D) -> void:
	health -= 20
