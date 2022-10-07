extends Node2D

class_name Main

export var randSpeedRange:float = 400
onready var atom_H_proto = preload("res://prefabs/atom_H.tscn")
onready var atom_O_proto = preload("res://prefabs/atom_O.tscn")


var H_list = []
var O_list = []

var time = 0
var count = 0


func generateAtomByID(id:int):
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
			return
			
	# 初始化速度与位置
	atom.global_position = $centerPos.global_position
	atom.velocity = randf() * randSpeedRange * Vector2.RIGHT.rotated(randf() * 360)
	$container.add_child(atom)


func calcSumEnergy():
	var sum = 0
	for atom in H_list:
		sum += atom.linear_velocity.length_squared()
	for atom in O_list:
		sum += 16 * atom.linear_velocity.length_squared()
	return sum / 2000

