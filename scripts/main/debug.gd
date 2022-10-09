extends Label

var message = ""
var main = null

func _ready():
	Debugger.initDebugger()
	# TODO:to global var
	main = get_node(@"/root/mainSpace")

func _process(_delta):
	self.text = ''.join([
		"ΣEk(动能)＝", str(main.calcSumEnergy()), "\n",
		"δ(分布系数)＝", str(main.calcDeltas()), "\n",
		message, "\n",
	])


# 修改此函数参数请一并修改GLOBAL/Debug.gd
func printl(string:String, isNode:bool = false):
	if(isNode):
		message = string.replace('@','_').replace(':',' ')
	else:	
		message = string
