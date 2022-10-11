extends RigidBody2D

const atomID:int = 1
const atomMass:int = 1
var isCaptured:bool = false setget setCaptured

# initial velocity
var velocity:Vector2 = Vector2.ZERO 
func _ready():
	self.linear_velocity = velocity
	self.mass = atomMass

func setCaptured(val):
	# layers: BIN mask to DEC
	if(val):
		self.layers = 2
	else:
		self.layers = 3
	isCaptured = val


func _onDestroyed():
	pass