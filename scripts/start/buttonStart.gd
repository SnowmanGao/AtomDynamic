extends Button


func _on_start_pressed():
	Settings.SaveList([
		"HOH_count",
		"init_Ek",
		"expression",
		"suihai_0",
		"suihai_1",
		"CD_seconds",
	])
	get_tree().change_scene("res://scene/main.tscn")
