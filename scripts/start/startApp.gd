extends Node2D

func _ready():
	OS.window_maximized = true
	Settings.Init()
	Settings.DisplayList([
		"VERSION",

		"HOH_count",
		"init_Ek",
		"expression",
		"suihai_0",
		"suihai_1",
		"CD_seconds",
	])
