extends Node2D

var speedRange:float
var atom_H_proto:Resource
var atom_O_proto:Resource
var Node_centerPos:Position2D
var Node_container:Node2D

var H_list = []
var O_list = []


func initAll():
	speedRange = Settings.Get("init_Ek")
	atom_H_proto = preload("res://prefabs/atom_H.tscn")
	atom_O_proto = preload("res://prefabs/atom_O.tscn")
	Node_centerPos = get_node(@"/root/mainSpace/centerPos")
	Node_container = get_node(@"/root/mainSpace/container")


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
			
	# 初始化位置与速度
	atom.global_position = Node_centerPos.global_position + \
			Vector2(randf() * OS.window_size.x, randf() * OS.window_size.y)
	
	atom.velocity = randf() * speedRange * \
			Vector2.RIGHT.rotated(randf() * 360)
	
	# 入树渲染
	Node_container.add_child(atom)
	return atom


var lastCalced_Ek = 0

func calcSumEnergy() -> float:
	var sum = 0
	for atom in H_list:
		sum += atom.linear_velocity.length_squared()
	for atom in O_list:
		sum += 16 * atom.linear_velocity.length_squared()
	lastCalced_Ek = sum / 2000
	return lastCalced_Ek


var lastCalced_deltas = []

func calcDeltas() -> Array:
	var count = len(O_list)
	var ans = [0,0,0]
	if (count == 0):
		return [null,null,null]

	for atom in O_list:
		ans[atom.capturedCount] += 1
	
	# DATAs.append([ans[0], ans[1], ans[2], lastCalced_Ek])
	lastCalced_deltas = ans
	return lastCalced_deltas


var lastCalcedFree_H = 0

func calcFree_H() -> int:
	var sum = 0
	for atom in H_list:
		print(atom.isCaptured)
		if !atom.isCaptured:
			sum += 1
	lastCalcedFree_H = sum
	return lastCalcedFree_H
			


var DATAs = []
var data_file = "user://deltaData.save"
func saveData():
	var file = File.new()
	file.open(data_file, File.WRITE)
	file.store_string(str(DATAs))
	file.close()