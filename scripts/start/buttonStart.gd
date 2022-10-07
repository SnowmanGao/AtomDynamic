extends Button


func _on_start_pressed():
	Settings.atom_H_count = int($"../atom_H_count/SpinBox".value)
	Settings.atom_O_count = int($"../atom_O_count/SpinBox".value)
	Settings.CD_seconds = $"../CD seconds/SpinBox".value
	Settings.probablity = $"../probablity/SpinBox".value
	get_tree().change_scene("res://scene/main.tscn")
