extends Label

var message = ""

func _ready():
	# TODO:使用signal实现
	Debugger.initDebugger()

func _process(_delta):
	self.text = ''.join([
		"ΣEk(总动能)＝", str(Main.calcSumEnergy()), "\n",
		"δ*N(分布数)＝", str(Main.calcDeltas()), "\n",
		"[H](游离H总数)＝", str(Main.calcFree_H()), "\n",
		"\n",
		message, "\n",
	])


# 修改此函数参数请一并修改GLOBAL/Debug.gd
func printl(string:String, isNode:bool = false):
	if(isNode):
		message = string.replace('@','_').replace(':',' ')
	else:	
		message = string
