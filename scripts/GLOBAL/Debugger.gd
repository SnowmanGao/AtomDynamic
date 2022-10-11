extends Node

var debugger = null

func initDebugger():
	# 当debug信息栏标签加载完毕时执行
	debugger = get_node(@"/root/mainSpace/ui/debugger")

func printl(string:String, isNode:bool = false):
	debugger.printl(string, isNode)

func eval(expr:String):
	var obj = Expression.new()
	obj.parse(expr)
	return obj.execute()