extends RigidBody2D

const atomID:int = 8
const atomMass:int = 16
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


# 强制俘获的原子静止
func _physics_process(_delta):
	for i in [0,1]:
		var atom = capturedAtomList[i]
		if(atom != null):
			atom.global_position = capturerList[i].global_position
			# atom.linear_velocity = Vector2.ZERO

# 设置碰撞检测状态
func setMonitor(l_0_r_1:int, state:bool):
	monitoring[l_0_r_1] = state

# 维护俘获系统的数据绑定
func setCapturedAtom(atom, l_0_r_1:int):
	if atom == null:
		# 释放
		capturedAtomList[l_0_r_1].isCaptured = false
		capturedAtomList[l_0_r_1] = null
		capturedCount = capturedCount - 1
		setMonitor(l_0_r_1, false)
	else:
		# 俘获
		atom.isCaptured = true
		capturedAtomList[l_0_r_1] = atom
		capturedCount = capturedCount + 1
		setMonitor(l_0_r_1, true)

# 计算俘获概率
func calcProbablity() -> float:
	match capturedCount:
		0:
			return Settings.Get("suihai_0")
		1:
			return Settings.Get("suihai_1")
	return 0.0


# 计算撞掉概率
var expr = Settings.Get("expression")
func calcFuckbality(v_square:float) -> float:
	# return 0.0327 * (atan(0.0002 * v_square - 0.327) + 1.5)
	return Debugger.eval(expr.replace("v_square", str(v_square)))


# 进入俘获区域事件
func _allInOneEntered(body, l_0_r_1:int):
	if(!monitoring):
		return

	if(body.get("atomID") == null):
		print("Exception: " + str(body))
		return

	match body.atomID:
		1:
			if(capturedAtomList[l_0_r_1] == null && \
				randf() < calcProbablity() && \
				body.isCaptured == false):

				# 空位俘获
				setCapturedAtom(body, l_0_r_1)

		8:
			if(capturedAtomList[l_0_r_1] != null &&\
				# TODO: 建议改为相对速度！
				randf() < calcFuckbality(body.linear_velocity.length_squared())):

				# O撞开了H
				setCapturedAtom(null, l_0_r_1)

		-1:
			if(capturedAtomList[l_0_r_1] != null &&\
				randf() < calcFuckbality(self.linear_velocity.length_squared())):

				# wall撞开了H			
				setCapturedAtom(null, l_0_r_1)


func _onDestroyed():
	for lr in [0,1]:
		if capturedAtomList[lr] != null:
			capturedAtomList[lr].linear_velocity = self.linear_velocity
			setCapturedAtom(null, lr)
