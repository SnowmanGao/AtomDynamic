extends Area2D

export(float) var dragingAreaMagni = 50.0
export(float) var forceSize = 2.0
var drag:bool = false

func _process(_delta):
	if(drag):
		get_parent().apply_impulse(
			Vector2.ZERO, forceSize * (get_global_mouse_position() - self.global_position)
		) 
		Debugger.printl(str(get_parent()), true)


func _on_areadrag_input_event(_viewport, event:InputEvent, _shape_idx):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if(event.is_pressed()):
			drag = true
			$"../circle".self_modulate = Color(0,10,255,255)
			$CollisionShape2D.scale = Vector2(dragingAreaMagni,dragingAreaMagni)
		else:
			drag = false
			$"../circle".self_modulate = Color(1,1,1,1)
			$CollisionShape2D.scale = Vector2(1,1)

	if(event is InputEventMouseButton and event.button_index == BUTTON_RIGHT):
		if(event.is_pressed()):
			get_parent()._onDestroyed()
			Main.Node_container.remove_child(get_parent())
