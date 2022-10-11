extends Area2D



func _on_clickArea_input_event(_viewport, event:InputEvent, _shape_idx):
	if(event is InputEventMouseButton and event.button_index == BUTTON_MIDDLE):
		if(event.is_pressed()):

			var atom = Main.generateAtomByID(1)
			atom.global_position = get_global_mouse_position()
			Main.Node_container.add_child(atom)
			Debugger.printl("释放 H+ 于 %s" % atom.global_position)
