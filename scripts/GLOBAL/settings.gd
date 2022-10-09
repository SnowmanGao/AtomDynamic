extends Node

var _all_settings = {}
var _VERSION = "2022.10.9"

func Register(name:String, default, type:String, bind:NodePath):
	# 注册
	_all_settings[name] = {
		"default": default,
		type: default,
		"bind": bind,
		"type": type
	}

func DisplayList(nameList:Array):
	# load and display
	for item in nameList:
		var key = _all_settings[item]
		if(get_node(key.bind) == null):
			print("错误: 找不到SettingsBind对象 " + key.bind)
			return
		get_node(key.bind)[key.type] = key[key.type]
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
	Register("init_Ek",  400, "value", NodePath(PATH + "init_Ek/SpinBox"))
	Register("expression",  "0.0327 * (atan(0.0002 * v_square - 0.327) + 1.5)", "text", NodePath(PATH + "expression/TextEdit"))
	Register("suihai_0",  0.6, "value", NodePath(PATH + "suihai_list/have0"))
	Register("suihai_1",  0.3, "value", NodePath(PATH + "suihai_list/have1"))
	Register("CD_seconds",  0.05, "value", NodePath(PATH + "CD_seconds/SpinBox"))
	Register("HOH_count",  40, "value", NodePath(PATH + "HOH_count/SpinBox"))
	print(_all_settings)
