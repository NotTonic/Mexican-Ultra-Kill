extends ColorRect

func unpause():
	get_tree().paused= false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Menu.visible = false
	
	
	
func pause():
	get_tree().paused = true
	$Menu.visible = true

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_think_b_pressed():
	pass # Replace with function body.
func _on_settings_b_pressed():
	$Menu.visible = false
	
	
func _on_return_b_pressed():
	unpause()
