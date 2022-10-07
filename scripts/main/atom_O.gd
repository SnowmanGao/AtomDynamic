extends RigidBody2D

const atomID:int = 8
const atomMass:int = 16
var captureProbablity:float = Settings.probablity
var capturerList = [null,null]
var capturedAtomList = [null,null]

# 赋予初速度
var velocity:Vector2 = Vector2.ZERO
func _ready():
	self.linear_velocity = velocity
	self.mass = atomMass
	self.capturerList = [get_node(@"area_l/vacancy_l"),get_node(@"area_r/vacancy_r")]


# warning-ignore:unused_argument
func _physics_process(delta):
	# 强制俘获的原子静止
	for i in [0,1]:
		var atom = capturedAtomList[i]
		if(atom != null):
			atom.global_position = capturerList[i].global_position
			atom.linear_velocity = Vector2.ZERO



func allInOneEntered(body, l_0_r_1:int):
	if(body.get("atomID") == null):
		print("Exception: " + str(body))
		return
	match body.atomID:
		1:
			if(randf() < captureProbablity && \
					capturedAtomList[l_0_r_1] == null && \
					body.isCaptured == false):
				# 三个条件，一次满足
				capturedAtomList[l_0_r_1] = body
				body.isCaptured = true
		8:
			# Debugger.printl("O")
			pass
		-1:
			# Debugger.printl("Wall")
			pass
