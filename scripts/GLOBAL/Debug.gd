extends Node

var debugger = null

func initDebugger():
	debugger = get_node(@"/root/mainSpace/ui/debugger")

func printl(string:String, isNode:bool = false):
	debugger.printl(string, isNode)
