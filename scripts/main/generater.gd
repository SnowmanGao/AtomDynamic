extends Timer

var count_H = 10
var count_O = 5
var CD = 0.1

var n:int = 0
var m:int = 0

func _ready():
	randomize()
	self.wait_time = CD
	self.count_H = Settings.atom_H_count
	self.count_O = Settings.atom_O_count
	self.CD = Settings.CD_seconds

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
