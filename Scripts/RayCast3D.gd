extends RayCast3D



# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass
