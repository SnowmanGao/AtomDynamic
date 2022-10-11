extends Timer

var count_HOH:int

var n:int = 0
var m:int = 0

func _ready():
	randomize()
	count_HOH = Settings.Get("HOH_count")
	self.wait_time = Settings.Get("CD_seconds")


func _on_Timer_timeout():
	if(n < count_HOH):
		var o = Main.generateAtomByID(8)
		var h0 = Main.generateAtomByID(1)
		var h1 = Main.generateAtomByID(1)
		o.setCapturedAtom(h0, 0)
		o.setCapturedAtom(h1, 1)
		n = n + 1
		return
	stop()
