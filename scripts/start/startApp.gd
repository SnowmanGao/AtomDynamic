extends Node2D

func _ready():
	Settings.Init()
	Settings.DisplayList([
		"VERSION",
		"atom_H_count",
		"atom_O_count",
		"CD_seconds",
		"probablity",
	])
