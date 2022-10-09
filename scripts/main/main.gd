extends Node2D

export var randSpeedRange:float = Settings.Get("init_Ek")
onready var atom_H_proto = preload("res://prefabs/atom_H.tscn")
onready var atom_O_proto = preload("res://prefabs/atom_O.tscn")
var Debugger = null


var H_list = []
var O_list = []

var time = 0
var count = 0

func initDebugger():
	Debugger = get_node("/root/mainSpace/ui/debugger")

func generateAtomByID(id:int) -> Node:
	var atom
	match id:
		1:
			atom = atom_H_proto.instance()
			H_list.append(atom)
		8:
			atom = atom_O_proto.instance()
			O_list.append(atom)
		_:
			print("Exception: AtomID = " + str(id))
			
	# 初始化速度与位置
	atom.global_position = $centerPos.global_position + Vector2(randf() * OS.window_size.x, randf() * OS.window_size.y)
	atom.velocity = randf() * randSpeedRange * Vector2.RIGHT.rotated(randf() * 360)
	$container.add_child(atom)
	return atom

var temp = 0
func calcSumEnergy():
	var sum = 0
	for atom in H_list:
		sum += atom.linear_velocity.length_squared()
	for atom in O_list:
		sum += 16 * atom.linear_velocity.length_squared()
	temp = sum / 2000
	return temp

# var DATAs = []
func calcDeltas():
	var ans = [0,0,0]
	for atom in O_list:
		ans[atom.capturedCount] = ans[atom.capturedCount] + 1
	# DATAs.append([ans[0], ans[1], ans[2], temp])
	return ans


# var data_file = "user://deltaData.save"
# func saveData():
# 	var file = File.new()
# 	file.open(data_file, File.WRITE)
# 	file.store_string(str(DATAs))
# 	file.close()