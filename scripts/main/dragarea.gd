extends Area2D

export(float) var dragingAreaMagni = 50
export(float) var forceSize = 2
var drag:bool = false

func _process(delta):
	if(drag):
		get_parent().apply_impulse(Vector2.ZERO,forceSize * (get_global_mouse_position() - self.global_position)) 
		Debugger.printl(str(get_parent()), true)


func _on_areadrag_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if(event.is_pressed()):
			drag = true
			$CollisionShape2D.scale = Vector2(dragingAreaMagni,dragingAreaMagni)
		else:
			drag = false
			$CollisionShape2D.scale = Vector2(1,1)
