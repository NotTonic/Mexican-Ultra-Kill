extends Node3D
const speed = 500.0

@onready var ray = $RayCast3D
var instance
var blood = load("res://scenes/particle_test.tscn")

func _ready():
	pass # Replace with function body.
func on_area_3d_area_entered(a):
		instance = blood.instantiate()
		instance.position = a.global_position
		instance.transform.basis = a.global_transform.basis
		get_parent().add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0, speed) * delta
	##on_area_3d_area_entered(a)

