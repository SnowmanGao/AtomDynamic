extends Label

var string = ""
var message = ""
var main = null

func _ready():
	Debugger.initDebugger()
	# TODO:to global var
	main = get_node(@"/root/mainSpace")

func _process(delta):
	self.text = "Σ动能＝" + \
			str(main.calcSumEnergy()) + \
			"\n" + \
			message

# 修改此函数参数请一并修改GLOBAL/Debug.gd
func printl(string:String, isNode:bool = false):
	if(isNode):
		message = string.replace('@','_').replace(':',' ')
	else:	
		message = string
