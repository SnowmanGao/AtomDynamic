extends Timer

var count_H
var count_O

var n:int = 0
var m:int = 0

func _ready():
	randomize()
	self.wait_time = Settings.Get("CD_seconds")
	self.count_H = Settings.Get("atom_H_count")
	self.count_O = Settings.Get("atom_O_count")

func _on_Timer_timeout():
	if(n < count_H):
		get_parent().generateAtomByID(1)
		n = n + 1
		return
	if(m < count_O):
		get_parent().generateAtomByID(8)
		m = m + 1
		return
	if(n >= count_H or m >= count_O):
		stop()
