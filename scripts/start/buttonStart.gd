extends Button


func _on_start_pressed():
	Settings.SaveList([
		"atom_H_count",
		"atom_O_count",
		"CD_seconds",
		"probablity",
	])
	get_tree().change_scene("res://scene/main.tscn")
