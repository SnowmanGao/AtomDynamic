extends RigidBody2D

const atomID:int = 8
const atomMass:int = 16
var captureProbablity:float = Settings.Get("probablity")
# 碰撞区域对象，用于定位俘获位置
var capturerList = [null, null]
# 俘获的原子的对象
var capturedAtomList = [null, null]
# 俘获数，用于计算俘获概率
var capturedCount = 0
# 碰撞检测开关
var monitoring = [true, true]

# 赋予初速度
var velocity:Vector2 = Vector2.ZERO
func _ready():
	self.linear_velocity = velocity
	self.mass = atomMass
	self.capturerList = [get_node(@"area_l/vacancy_l"),get_node(@"area_r/vacancy_r")]


func _physics_process(_delta):
	# 强制俘获的原子静止
	for i in [0,1]:
		var atom = capturedAtomList[i]
		if(atom != null):
			atom.global_position = capturerList[i].global_position
			atom.linear_velocity = Vector2.ZERO


func setMonitor(L0R1:int, state:bool):
	monitoring[L0R1] = state

func setCapturedAtomList(L0R1:int, atom, op:bool):
	capturedAtomList[L0R1] = atom
	if op:
		capturedCount = capturedCount + 1
	else:
		capturedCount = capturedCount - 1

func calcProbablity() -> float:
	match capturedCount:
		0:
			return 0.6
		1:
			return 0.3
	return 0.0

func calcFuckbality(v_square:float) -> float:
	return 0.327 * (atan(0.0002 * v_square - 0.327) + 1.5)

func allInOneEntered(body, L0R1:int):
	if(!monitoring):
		return

	if(body.get("atomID") == null):
		print("Exception: " + str(body))
		return

	match body.atomID:
		1:
			if(capturedAtomList[L0R1] == null && \
			randf() < calcProbablity() && \
				body.isCaptured == false):
				
				# 三个条件，一次满足
				body.isCaptured = true
				setCapturedAtomList(L0R1, body, true)
				setMonitor(L0R1, false)
			# if(capturedAtomList[L0R1] != null && \
			# 	randf() < captureProbablity * 0.4):

			# 	# NTR !!!
			# 	body.isCaptured = true
			# 	capturedAtomList[L0R1].isCaptured = false					
			# 	capturedAtomList[L0R1] = body
			# 	setMonitor(L0R1, false)
		8:
			if(capturedAtomList[L0R1] != null &&\
				# TODO: 建议改为相对速度！
				randf() < calcFuckbality(body.linear_velocity.length_squared())):

					# O撞开了H
					capturedAtomList[L0R1].isCaptured = false					
					setCapturedAtomList(L0R1, null, false)
					setMonitor(L0R1, true)
		-1:
			if(capturedAtomList[L0R1] != null &&\
				randf() < calcFuckbality(self.linear_velocity.length_squared())):

					# wall撞开了H
					capturedAtomList[L0R1].isCaptured = false					
					setCapturedAtomList(L0R1, null, false)
					setMonitor(L0R1, true)
