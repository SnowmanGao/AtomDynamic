extends Label

var string = ""
var message = ""

func _process(delta):
	self.text = "ΣE(k) = " + \
			str(get_parent().calcSumEnergy()) + \
			"\n\n" + \
			message

func printl(s:String):
	message = s
