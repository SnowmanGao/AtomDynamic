extends Node

var _all_settings = {}
var _VERSION = "2022.10.8"

func Register(name:String, default, type:String, bind:NodePath):
	# 注册
	_all_settings[name] = {
		"default": default,
		"value": default,
		"bind": bind,
		"type": type
	}

func DisplayList(nameList:Array):
	# load and display
	for item in nameList:
		var key = _all_settings[item]
		get_node(key.bind)[key.type] = key.value
	print(get_node("/root/startApp/CD_seconds/SpinBox").value)

func SaveList(nameList:Array):
	for item in nameList:
		var key = _all_settings[item]
		key.value = get_node(key.bind)[key.type]

func Get(name:String):
	return _all_settings[name].value

func Set(name:String, value):
	_all_settings[name].value = value

func Init():
	var PATH = "/root/startApp/"
	Register("VERSION", "ver.　" + _VERSION, "text", NodePath(PATH + "version"))
	Register("atom_H_count",  40, "value", NodePath(PATH + "atom_H_count/SpinBox"))
	Register("atom_O_count",  20, "value", NodePath(PATH + "atom_O_count/SpinBox"))
	Register("CD_seconds",  0.05, "value", NodePath(PATH + "CD_seconds/SpinBox"))
	Register("probablity",  0.2, "value", NodePath(PATH + "probablity/SpinBox"))
	print(_all_settings)
